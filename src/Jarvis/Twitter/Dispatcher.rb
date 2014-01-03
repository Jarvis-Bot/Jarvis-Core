module Jarvis
  class Dispatcher
    def self.dispatch(message)
      case message
      when Twitter::Tweet
        if message[:deleted]
          Viewer::deleted_tweet(message)
          Handler::deleted_tweet(message)
        else
          Viewer::tweet(message)
          Handler::tweet(message)
        end
      when Twitter::DirectMessage
        Viewer::direct_message(message)
        Handler::direct_message(message)
      when Twitter::Streaming::Event
        Viewer::event(message)
        Handler::event(message)
      when Twitter::Streaming::FriendList
        Viewer::friend_list(message)
        Handler::friend_list(message)
      end
    end
  end
end
