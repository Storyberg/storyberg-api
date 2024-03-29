require 'httparty'
require 'cgi'

class Storyberg
  @key = nil
  @host = 'a.storyberg.com'

  def self.api_key
    @key
  end

  def self.event(user_id, name)
    return false unless self.is_initialized?

    field_values = {'api_key' => @key, 'sb_event' => name, 'user_id' => user_id}
    self.request 'project_user_events/create', field_values
  end

  def self.identify(user_id, user_attributes = {})
    return false unless self.is_initialized?

    field_values = hash_keys_to_str user_attributes
    field_values.update('api_key' => @key)
    field_values.update('user_id' => user_id)

    if field_values.has_key? 'tag'
      field_values.update 'sb_tag' => field_values['tag']
      field_values.delete 'tag'
    end
    
    self.request 'project_users/identify', field_values
  end

  def self.init(key, host = nil)
    @key = key
    @host = host unless host == nil
  end

  def self.record(user_id)
    return false unless self.is_initialized?

    self.event(user_id, 'key')
  end
  
  def self.paid(user_id)
    return false unless self.is_initialized?

    self.event(user_id, 'paid')
  end

  private
  def self.get(url)
    begin
      return HTTParty.get(url)
    rescue Exception => e
      raise e.exception(e.message)
    end
  end

  def self.hash_keys_to_str(hash)
    Hash[*hash.map { |k, v| k.class == Symbol ? [k.to_s, v] : [k, v] }.flatten] # convert all keys to strings
  end

  def self.is_initialized?
    return false if @key == nil
    true
  end

  def self.request(action, field_values)
    params = []
    field_values.each do |field, value|
      params << "#{CGI::escape(field.to_s)}=#{CGI::escape(value.to_s)}"
    end

    query_string = params.join("&")
    response = self.get("http://#{@host}/#{action}.json?#{query_string}")
    return response.body unless response.nil?
    return false
  end
end
