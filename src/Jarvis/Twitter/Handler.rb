module Jarvis
  class Handler
    attr_accessor :is_matched
    def initialize(tweet, answer_instance)
      loader = Loader.new
      @tweet                   = tweet
      @triggers_list           = loader.triggers_list
      @plugins_full_infos_list = loader.plugins_full_infos_list
      @answer_instance         = answer_instance
      @is_matched              = self.match_triggers?
      receive_tweet
    end

    def receive_tweet
      if @tweet.user.screen_name != "VBbot" && @is_matched
        send_tweet_to_plugin(@plugin_name, @trigger_detected)
      end
    end

    def send_tweet_to_plugin(plugin_name, trigger_detected)
      caller = Caller.new(@answer_instance, @plugins_full_infos_list[plugin_name], @tweet, trigger_detected)
    end

    def match_triggers?
      @triggers_list.each { |plugin_name, plugin_triggers|
        plugin_triggers.each { |trigger_word|
          if @tweet.text.include?(trigger_word)
            @trigger_detected = trigger_word
            @plugin_name = plugin_name
            return true
          end
        }
      }
    end
  end
end