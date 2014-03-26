module Jarvis
  module Messages
    class Factory
      attr_reader :from, :timestamp, :message, :service_object
      def initialize(service_name, service_object, message)
        @timestamp = Time.now
        @from = service_name.to_sym
        @message = message
        @service_object = service_object
        Handler.new(self)
      end
    end
  end
end
