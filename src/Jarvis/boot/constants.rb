module Jarvis
  module Boot
    class Constants
      def initialize
        JARVIS[:root] = root
        JARVIS[:debug] = debug
        JARVIS[:version] = version
      end

      def root
        File.expand_path(File.join(__dir__, '..', '..', '..'))
      end

      def debug
        ARGV.include? '--debug'
      end

      def version
        v = {}
        v[:major] = 1
        v[:minor] = 4
        v[:patch] = 2
        v[:pre] = nil
        v
      end
    end
  end
end
