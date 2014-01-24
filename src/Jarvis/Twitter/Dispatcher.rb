module Jarvis
  class Dispatcher
      case message
      when Twitter::Tweet
        if message[:deleted]
          Viewer::deleted_tweet(message)
        else
          Viewer::tweet(message)
        end
      when Twitter::DirectMessage
        Viewer::direct_message(message)
      when Twitter::Streaming::Event
        Viewer::event(message)
      when Twitter::Streaming::FriendList
        Viewer::friend_list(message)
      end
    end
  end
end
