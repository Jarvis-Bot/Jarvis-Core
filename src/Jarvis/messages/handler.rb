module Jarvis
  module Messages
    class Handler
      def initialize(message)
        @timestamp = message.timestamp
        @from = message.from
        @message = message.text
        @sorted_receivers = Boot::Session.sorted_registered_receivers
        dispatcher
      end

      def dispatcher
        call_receiver(:all) unless @sorted_receivers[:all].nil?
        call_receiver(@from) unless @sorted_receivers[@from].nil?
      end

      def call_receiver(from)
        @sorted_receivers[from].each do |receiver|
          args = { timestamp: @timestamp, message: @message, from: @from, to: receiver[:name] }
          Utility::Viewer::Message.new(args)
          require File.join("#{receiver[:directory]}", 'init.rb')
          Object.const_get("#{receiver[:class_name]}").new(args)
        end
      end
    end
  end
end
