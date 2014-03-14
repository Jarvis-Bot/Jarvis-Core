module Jarvis
  module Utility
    class Viewer

      def self.debug(log)
        puts color_factory(:cyan, log)
      end

      def self.warning(log)
        puts color_factory(:yellow, log)
      end

      def self.error(log)
        puts color_factory(:red, log)
      end

      def self.info(log)
        puts color_factory(:blue, log)
      end

      def self.color_factory(color, log)
        Rainbow("████ #{log}").fg(color)
      end

    end
  end
end
