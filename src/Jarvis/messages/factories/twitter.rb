module Jarvis
  module Messages
    module Factories
      class Twitter < Factory
        def initialize(twitter_object)
          super(:twitter)
          @twitter_object = twitter_object
        end
      end
    end
  end
end
