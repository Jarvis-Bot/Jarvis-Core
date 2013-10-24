require 'twitter'
require './config/keys.rb'
class Clients
  @keys = Keys.getKeys
  def self.getREST
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = @keys[:consumer_key]
      config.consumer_secret     = @keys[:consumer_secret]
      config.access_token        = @keys[:access_token]
      config.access_token_secret = @keys[:access_token_secret]
    end
    return client
  end

  def self.getStream
    puts @keys
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = @keys[:consumer_key]
      config.consumer_secret     = @keys[:consumer_secret]
      config.access_token        = @keys[:access_token]
      config.access_token_secret = @keys[:access_token_secret]
    end
    return client
  end
end