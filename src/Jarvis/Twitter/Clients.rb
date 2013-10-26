module Jarvis
  class Clients
    attr_accessor :client_REST, :client_stream
    def initialize
      keys = Keys.new
      @keys = keys.keys
      @client_REST = start_client_REST
      @client_stream = start_client_stream
    end

    def start_client_REST
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = @keys["consumer_key"]
        config.consumer_secret     = @keys["consumer_secret"]
        config.access_token        = @keys["access_token"]
        config.access_token_secret = @keys["access_token_secret"]
      end
      return client
    end

    def start_client_stream
      client = Twitter::Streaming::Client.new do |config|
        config.consumer_key        = @keys["consumer_key"]
        config.consumer_secret     = @keys["consumer_secret"]
        config.access_token        = @keys["access_token"]
        config.access_token_secret = @keys["access_token_secret"]
      end
      return client
    end
  end
end