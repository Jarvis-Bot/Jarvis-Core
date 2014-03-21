module Jarvis
  module Boot
    class Sources
      def self.start
      	Jarvis::Utility::Logger.info('Starting Twitter streaming client...')
      	Jarvis::Sources::Twytter::Streaming.client.user(with: 'user') do |message|
      	  if message.is_a?(Twitter::Tweet)
      	    Jarvis::Utility::Viewer::Message.tweet(message)
            unless message.user.screen_name == Jarvis::Boot::Session.twitter_current_user.screen_name
              Jarvis::Messages::Factories::Twitter.new(message)
           end
      	  end
        end
    	end
    end
  end
end
