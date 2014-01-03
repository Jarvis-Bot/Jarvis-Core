module Jarvis
  class Viewer
    def self.create_prefix(type)
      # You can use [black,red,green,yellow,blue,magenta,cyan,white,default]
      # See https://github.com/sickill/rainbow for more information
      case type
      when "tweet"
        color = "green"
      when "deleted_tweet"
        color = "red"
      when "direct_message"
        color = "magenta"
      when "event"
        color = "blue"
      when "friend_list"
        color = "yellow"
      when "welcome_message"
        color = "cyan"
      end
      return '████ '.foreground(color.to_sym)
    end

    def self.welcome_message(user)
      # Twitter::User
      # https://dev.twitter.com/docs/api/1.1/get/account/verify_credentials
      prefix       = self.create_prefix("welcome_message")
      screen_name  = user.screen_name
      nb_followers = user.followers_count.to_s

      # ████ Jarvis is online on @PSEUDO. You have X follower(s).
      puts prefix + "Jarvis is online on @#{screen_name}. You have #{nb_followers} follower(s)."
    end

    def self.tweet(tweet)
      # Twitter::Tweet
      # https://dev.twitter.com/docs/platform-objects/tweets
      prefix      = self.create_prefix("tweet")
      screen_name = '@' + tweet.user.screen_name.foreground(:cyan)
      name        = ' [' + tweet.user.name.foreground(:yellow) + ']: '
      text        = tweet.text.bright

      # ████@PSEUDO [REAL_NAME]: This is a tweet
      puts prefix + screen_name + name + text
    end

    def self.deleted_tweet(deleted_tweet)
      # Twitter::Tweet
      # https://dev.twitter.com/docs/streaming-apis/messages#Status_deletion_notices_delete
      prefix   = self.create_prefix("deleted_tweet")
      id_tweet = deleted_tweet[:id].to_s.foreground(:cyan)

      # ████ tweet XXX deleted
      puts prefix + "tweet " + id_tweet + " deleted"
    end

    def self.direct_message(direct_message)
      # Twitter::DirectMessage
      # https://dev.twitter.com/docs/platform-objects/tweets
      prefix      = self.create_prefix("direct_message")
      screen_name = '@' + tweet.user.screen_name.foreground(:cyan)
      name        = ' [' + tweet.user.name.foreground(:yellow) + ']: '
      text        = tweet.text.bright

      # ████@PSEUDO [REAL_NAME]: This is a direct message
      puts prefix + screen_name + name + text
    end

    def self.event(event)
      # TODO
      # Twitter::Streaming::Event
      # https://github.com/sferik/twitter/blob/master/lib/twitter/streaming/event.rb
      # https://dev.twitter.com/docs/streaming-apis/messages#Events_event
      # {
      #   "target": TARGET_USER,
      #   "source": SOURCE_USER,
      #   "event":"EVENT_NAME",
      #   "target_object": TARGET_OBJECT,
      #   "created_at": "Sat Sep 4 16:10:54 +0000 2010"
      # }
      prefix      = self.create_prefix("event")
      puts prefix + "event (Not handled yet)"
    end

    def self.friend_list(friend_list)
      # Twitter::Streaming::FriendList
      # https://dev.twitter.com/docs/streaming-apis/messages#Friends_lists_friends
      prefix  = self.create_prefix("friend_list")
      message = "You've #{friend_list.friend_ids.length} following."
      puts prefix + message
    end
  end
end
