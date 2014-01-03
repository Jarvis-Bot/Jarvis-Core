module Jarvis
  class Handler
    loader                   = Loader.new()
    @triggers_list           = loader.triggers_list
    @plugins_full_infos_list = loader.plugins_full_infos_list
    def self.tweet(tweet)
        if self.match_triggers?(tweet)
            pp tweet.text
        end
    end

    def self.deleted_tweet(deleted_tweet)
    end

    def self.direct_message(direct_message)
    end

    def self.event(event)
    end

    def self.friend_list(friend_list)
    end

    private
        def self.match_triggers?(tweet)
          @triggers_list.each { |plugin_name, plugin_triggers|
            plugin_triggers.each { |trigger_word|
              if tweet.text.include?(trigger_word)
                @trigger_detected = trigger_word
                @plugin_name = plugin_name
                return true
              end
            }
          }
        end
    end
end
