module Jarvis
  module Addons
    class Clients
      def initialize
        clients = Jarvis::Addons::Addons.new(:clients)
      end
    end
  end
end
