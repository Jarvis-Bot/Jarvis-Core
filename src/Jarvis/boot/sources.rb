module Jarvis
  module Boot
  	Utility::Logger.info('Starting Twitter streaming client...')
  	Sources::Twytter::Streaming.client.user(with: 'user') do |message|
  	  if message.is_a?(Twitter::Tweet)
  	    Utility::Viewer::Message.tweet(message)
  	    Messages::Factories::Twitter.new(message)
  	  end
  	end
  end
end
