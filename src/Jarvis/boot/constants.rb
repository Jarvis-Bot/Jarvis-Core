module Jarvis
  module Boot
    class Constants
      def initialize
        JARVIS[:root] = root
        JARVIS[:debug] = debug
      end

      def root
        File.expand_path(File.join(__dir__, '..', '..', '..'))
      end

      def debug
        ARGV.include? '--debug'
      end
    end
  end
end
