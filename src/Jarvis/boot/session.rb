module Jarvis
  module Boot
    class Session
      attr_reader :twitter_current_user

      class << self
        def twitter_current_user
          puts "self.twitter_current_user"
          @@twitter_current_user ||= Jarvis::Sources::Twytter::REST.client.verify_credentials(include_entities: false, skip_status: false)
        end
      end
    end
  end
end