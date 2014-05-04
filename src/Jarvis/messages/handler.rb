module Jarvis
  module Messages
    class Handler
      def initialize(message)
        @timestamp = message.timestamp
        @from = message.from
        @message = message.text
        @message_object = message.message_object
        dispatcher
      end

      def dispatcher
        call_receivers(Jarvis::API::Addons.call_receivers_for(:all))
        call_receivers(Jarvis::API::Addons.call_receivers_for(@from))
      end

      def call_receivers(receivers)
        receivers.each do |receiver|
          receiver = receiver.values[0]
          args = { timestamp: @timestamp, message: @message, from: @from, to: receiver['specs']['name'], object: @message_object }
          Utility::Viewer::Message.new(args)
          require File.join("#{receiver['directory']}", 'init.rb')
          Object.const_get("#{receiver['specs']['class_name']}").new(args)
        end
      end
    end
  end
end
