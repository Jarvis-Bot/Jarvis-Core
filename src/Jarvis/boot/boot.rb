module Jarvis
  module Boot
    class Boot
      def initialize
        @sources = Jarvis::Boot::Session.addons[:sources]
        @clients = Jarvis::Boot::Session.addons[:clients]
        @receivers = Jarvis::Boot::Session.addons[:receivers]

        display_count
        start_sources
      end

      def display_count
        to_count = {}
        to_count[:sources] = @sources.display_count
        to_count[:clients] = @clients.display_count
        to_count[:receivers] = @receivers.display_count
        @abort_message = ''
        to_count.each do |type, count|
          @addon_missing = count == 0 || @addon_missing
          type = type.to_s.chomp('s')
          @abort_message <<  "I'm sorry, I can't start with #{count} #{type}. \n" if count == 0
        end
        Jarvis::Utility::Logger.error(@abort_message.strip) if @addon_missing
      end

      def start_sources
        Jarvis::Addons::Sources.new(@sources).launch
      end
    end
  end
end
