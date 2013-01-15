require 'httparty'

class Storyberg 
  def self.woo
    puts "woo"
  end


  def self.get(url)
    begin
      return HTTParty.get(url)
    rescue Exception => e
      raise e.exception(e.message)
    end
  end
end
