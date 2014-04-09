module Jarvis
  module Messages
    class Handler
      def initialize(message)
        @timestamp = message.timestamp
        @from = message.from
        @message = message.text
        @sorted_receivers = ThirdParty::Receivers::Registered.new.sorted
        dispatcher
      end

      def dispatcher
        require 'pp'
        pp @from, @sorted_receivers[:all], @sorted_receivers[@from]
      end
    end
  end
end