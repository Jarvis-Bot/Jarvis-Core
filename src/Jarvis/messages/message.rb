module Jarvis
  module Messages
    class Message
      attr_reader :timestamp, :from, :text
      def initialize(service_name, message)
        @timestamp = Time.now
        @from = service_name.downcase.to_sym
        @text = message
        Handler.new(self)
      end
    end
  end
end
