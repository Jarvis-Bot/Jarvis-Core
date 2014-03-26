module Jarvis
  module Sources
    module Twytter
      class Streaming

        def self.client
          keys = Keys.twitter

          Twitter::Streaming::Client.new do |config|
            config.consumer_key        = keys['consumer_key']
            config.consumer_secret     = keys['consumer_secret']
            config.access_token        = keys['access_token']
            config.access_token_secret = keys['access_token_secret']
          end

        end

      end
    end
  end
end
