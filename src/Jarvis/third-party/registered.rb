module Jarvis
  module ThirdParty
    class Registered
      def self.client(name, call=false)
        @client = Jarvis::Boot::Session.all_sorted[:clients][format_name(name)]
        return_client_object unless call
      end

      def self.receiver(name)
        Jarvis::Boot::Session.all_sorted[:receivers][format_name(name)]
      end

      def self.source(name)
        Jarvis::Boot::Session.all_sorted[:sources][format_name(name)]
      end

      def self.format_name(name)
        name.downcase.to_sym
      end

      def self.return_client_object
        require "#{@client['directory']}/init"
        Object.const_get(@client['client']['class name']).init
      end
    end
  end
end
