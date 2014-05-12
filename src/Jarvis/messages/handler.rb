module Jarvis
  module Messages
    class Handler
      def initialize(message)
        @timestamp = message.timestamp
        @from = format_service_name(message.from)
        @message = message.text
        @message_object = message.message_object
        dispatcher
      end

      def dispatcher
        all = call_receivers(Jarvis::API::Addons.call_receivers_for(:all))
        from = call_receivers(Jarvis::API::Addons.call_receivers_for(@from[:to_call]))
        if all.empty? && from.empty?
          args = { timestamp: @timestamp, message: @message, from: @from[:to_display], found: false }
          Utility::Viewer::Message.new(args)
        end
      end

      def call_receivers(receivers)
        receivers.each do |receiver|
          receiver = receiver.values[0]
          args = { timestamp: @timestamp, message: @message, from: @from[:to_display], to: receiver['specs']['name'], object: @message_object, found: true }
          Utility::Viewer::Message.new(args)
          require File.join("#{receiver['directory']}", 'init.rb')
          Object.const_get("#{receiver['specs']['class_name']}").new(args)
        end
      end

      def format_service_name(service_name)
        services = {}
        case service_name
        when String
          services.store(:to_call, service_name.downcase.to_sym)
          services.store(:to_display, service_name.downcase.to_sym)
        when Symbol
          services.store(:to_call, service_name.downcase)
          services.store(:to_display, service_name.downcase)
        when Hash
          services.store(:to_call, service_name[:sub_source].downcase.to_sym)
          services.store(:to_display, service_name[:source].downcase.to_sym)
        end
        services
      end
    end
  end
end
