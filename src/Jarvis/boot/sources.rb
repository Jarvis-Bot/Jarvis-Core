module Jarvis
  module Boot
    class Sources
      def self.start
      	Jarvis::Utility::Logger.info('Starting Twitter streaming client...')
      	Jarvis::Sources::Twytter::Streaming.client.user(with: 'user') do |message|
      	  if message.is_a?(Twitter::Tweet)
      	    Jarvis::Utility::Viewer::Message.tweet(message)
      	    Jarvis::Messages::Factories::Twitter.new(message)
      	  end
        end
    	end
    end
  end
end
