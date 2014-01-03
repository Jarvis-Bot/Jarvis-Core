module Jarvis
  class Clients
    def self.keys
      keys = YAML.load_file('../config/keys.yml')
    end

    def self.rest
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = self.keys["consumer_key"]
        config.consumer_secret     = self.keys["consumer_secret"]
        config.access_token        = self.keys["access_token"]
        config.access_token_secret = self.keys["access_token_secret"]
      end
      return client
    end

    def self.stream
      client = Twitter::Streaming::Client.new do |config|
        config.consumer_key        = self.keys["consumer_key"]
        config.consumer_secret     = self.keys["consumer_secret"]
        config.access_token        = self.keys["access_token"]
        config.access_token_secret = self.keys["access_token_secret"]
      end
      return client
    end
  end
end
