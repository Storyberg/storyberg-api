require 'httparty'
require 'cgi'

class Storyberg
  @key = nil
  @host = 'k.storyberg.com'

  def self.api_key
    @key
  end

  def self.identify(user_id, user_attributes = {})
    return false unless self.is_initialized?

    field_values = hash_keys_to_str user_attributes
    field_values.update('k' => @key)
    field_values.update('u' => user_id)
    
    self.request 'project_users/identify', field_values
  end

  def self.init(key, host = nil)
    @key = key
    @host = host unless host == nil
  end

  def self.record(user_id, user_attributes = {})
    return false unless self.is_initialized?

    field_values = hash_keys_to_str user_attributes
    field_values.update('k' => @key)
    field_values.update('u' => user_id)
    self.identify user_id, user_attributes
    self.request 'project_user_events/record', field_values
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
    self.get("http://#{@host}/#{action}?#{query_string}")
  end
end
