require 'rainbow'
module Jarvis
  module Utility
    module Viewer
      class Log

        def self.debug
          puts color_factory(:cyan)
        end

        def self.warning
          puts color_factory(:yellow)
        end

        def self.error
          puts color_factory(:red)
          abort
        end

        def self.info
          puts color_factory(:blue)
        end

        def self.color_factory(color)
          prefix = @options[:block] ? '████ ' : ''
          Rainbow("#{prefix}#{@log}").fg(color)
        end

        def self.log_factory(type, log, options)
          @log = log
          @options = options
          self.send(type)
        end
      end
    end
  end
end
