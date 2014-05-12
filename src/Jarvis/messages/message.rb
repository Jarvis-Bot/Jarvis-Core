module Jarvis
  module Messages
    class Message
      attr_reader :timestamp, :from, :text, :message_object
      def initialize(service_name, message, message_object = nil)
        @timestamp = Time.now
        @from = service_name
        @text = message
        @message_object = message_object
        Handler.new(self)
      end
    end
  end
end
