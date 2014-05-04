module Jarvis
  module Boot
    class Constants
      def initialize
        JARVIS[:root] = root
        JARVIS[:debug] = debug
      end

      def root
        File.expand_path(File.join('..'))
      end

      def debug
        if ARGV.include? '--debug'
          ARGV.delete('--debug')
          true
        end
      end
    end
  end
end
