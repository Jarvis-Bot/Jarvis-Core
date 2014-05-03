module Jarvis
  module Boot
    class Boot
      def initialize
        @sources = Jarvis::Boot::Session.every_addons[:sources]
        @clients = Jarvis::Boot::Session.every_addons[:clients]
        @receivers = Jarvis::Boot::Session.every_addons[:receivers]
        display_count
        start_sources
      end

      def display_count
        @sources.display_count
        @clients.display_count
        @receivers.display_count
      end

      def start_sources
        Jarvis::Addons::Sources.new(@sources).launch
      end
    end
  end
end
