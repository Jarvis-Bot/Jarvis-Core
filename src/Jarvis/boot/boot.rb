module Jarvis
  module Boot
    class Boot
      def initialize
        addons
      end

      def addons
        sources = Jarvis::Addons::Sources.new
        clients = Jarvis::Addons::Clients.new
        receivers = Jarvis::Addons::Receivers.new

        sources.launch
      end
    end
  end
end
