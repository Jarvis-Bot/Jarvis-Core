module Jarvis
  module Utility
    module Viewer
      class Message

        def self.tweet(tweet)
          # Twitter::Tweet
          # https://dev.twitter.com/docs/platform-objects/tweets
          prefix      = Rainbow('████').fg(:green)
          screen_name = Rainbow("@#{tweet.user.screen_name}").fg(:cyan)
          name        = '[' + Rainbow("#{tweet.user.name}").fg(:yellow) + ']'
          text        = Rainbow(tweet.text).bright

          # ████ @PSEUDO [REAL_NAME]: This is a tweet
          puts "#{prefix} #{screen_name} #{name} #{text}"
        end

      end
    end
  end
end
