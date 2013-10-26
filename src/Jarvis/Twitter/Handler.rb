module Jarvis
  class Handler
    def initialize(tweet)
      loader = Loader.new
      @triggers_list           = loader.triggers_list
      @plugins_full_infos_list = loader.plugins_full_infos_list
      receive_tweet(tweet)
    end

    def receive_tweet(tweet)
      if self.match_triggers?(tweet.text)
        send_tweet_to_plugin(@plugin_name, tweet, @trigger_detected)
      end
    end

    def send_tweet_to_plugin(plugin_name, tweet, trigger_detected)
      caller = Caller.new(@plugins_full_infos_list[plugin_name], tweet, trigger_detected)
    end

    def match_triggers?(text)
      @triggers_list.each { |plugin_name, plugin_triggers|
        plugin_triggers.each { |trigger_word|
          if text.include?(trigger_word)
            @trigger_detected = trigger_word
            @plugin_name = plugin_name
            return true
          end
        }
      }
    end
  end
end