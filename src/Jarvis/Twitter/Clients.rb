module Jarvis
  class Clients
    def self.keys
      YAML.load_file('../config/keys.yml')
    end

    def self.rest
      rest_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = keys['consumer_key']
        config.consumer_secret     = keys['consumer_secret']
        config.access_token        = keys['access_token']
        config.access_token_secret = keys['access_token_secret']
      end
      rest_client
    end

    def self.stream
      stream_client = Twitter::Streaming::Client.new do |config|
        config.consumer_key        = keys['consumer_key']
        config.consumer_secret     = keys['consumer_secret']
        config.access_token        = keys['access_token']
        config.access_token_secret = keys['access_token_secret']
      end
      stream_client
    end
  end
end
