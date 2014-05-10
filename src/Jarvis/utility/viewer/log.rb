require 'rainbow'
module Jarvis
  module Utility
    module Viewer
      class Log
        def self.debug
          puts color_factory(:cyan) if JARVIS[:debug]
        end

        def self.warning
          puts color_factory(:yellow)
        end

        def self.error
          puts color_factory(:red)
          abort
        end

        def self.info
          puts color_factory(@options[:color] || :blue) if @options[:view] != false
        end

        def self.color_factory(color)
          Rainbow("#{@log}").fg(color)
        end

        def self.log_factory(type, log, options)
          @log = log
          @options = options
          send(type) if self.respond_to?(type)
        end
      end
    end
  end
end
