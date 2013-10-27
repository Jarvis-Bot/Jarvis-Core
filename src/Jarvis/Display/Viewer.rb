module Jarvis
  class Viewer
    def initialize(tweet, handler_instance)
      @handler    = handler_instance
      @is_matched = @handler.is_matched
      @tweet      = tweet
    end

    def create_prefix
      if @is_matched
        prefix = '██'.foreground(:green)
      else
        prefix = '██'.foreground(:red)
      end
      return prefix
    end

    def display
      prefix      = self.create_prefix + ' '
      screen_name = @tweet.user.screen_name.foreground(:cyan)
      name        = ' [' + @tweet.user.name.foreground(:yellow) + ']: '
      text        = @tweet.text.bright

      # ████ @PSEUDO [REALNAME]: This is a tweet
      prettyTweet = prefix + screen_name + name + text
      puts prettyTweet
    end    
  end
end