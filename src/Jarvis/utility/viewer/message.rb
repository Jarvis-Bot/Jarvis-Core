module Jarvis
  module Utility
    module Viewer
      class Message
        def initialize(options)
          @options = options
          build_message
        end

        def build_message
          from_color = color(:from, @options[:from])
          to_color   = color(:to, @options[:to])
          block_from = Rainbow('██').color(from_color)
          block_to   = Rainbow('██').color(to_color)
          timestamp  = @options[:timestamp].strftime('%H:%M:%S')
          from       = Rainbow(format_service(@options[:from])).color(from_color)
          to         = Rainbow(format_service(@options[:to])).color(to_color)
          message    = @options[:message]
          arrow      = '→'

          puts "#{block_from}#{block_to} #{timestamp} [#{from}]#{arrow}[#{to}] #{message}"
          # ████ 21:29:34 [TWITTER]→[SAVER] @author incredible tweet much retweeted
        end

        def format_service(service)
          service.upcase[0..14].strip
        end

        def color(type, name)
          all = Boot::Session.all_sorted

          case type
          when :from
            addon_type = :sources
          when :to
            addon_type = :receivers
          end
          all[addon_type][name.downcase.to_sym]['specs']['color_message']
        end
      end
    end
  end
end
