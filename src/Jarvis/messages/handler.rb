module Jarvis
  module Messages
    class Handler
      def initialize(message)
        @timestamp = message.timestamp
        @from = message.from
        @message = message.text
        @sorted_receivers = Boot::Session.registered_receivers
        dispatcher
      end

      def dispatcher

      end
    end
  end
end