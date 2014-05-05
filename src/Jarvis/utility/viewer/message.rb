module Jarvis
  module Utility
    module Viewer
      class Message
        def initialize(options)
          @options = options
          @built_messsage = {}
          @options[:found] ? receiver_found : receiver_not_found
        end

        def receiver_not_found
          overwrite = {
            to_color: '000000',
            to: '',
            prefix: Rainbow('✘').color(:red),
            arrow: ''
          }
          factory(overwrite)
          b = @built_messsage
          puts "#{b[:prefix]} #{b[:block_from]}#{b[:block_to]} #{b[:timestamp]} [#{b[:from]}] #{b[:message]}"
          log("[Receiver Not Found] [#{@options[:from]}] #{@options[:message]}")
        end

        def receiver_found
          factory
          b = @built_messsage
          puts "#{b[:prefix]} #{b[:block_from]}#{b[:block_to]} #{b[:timestamp]} [#{b[:from]}]#{b[:arrow]}[#{b[:to]}] #{b[:message]}"
          log("[Receiver Found] [#{@options[:from]}] #{@options[:message]}")
        end

        def factory(overwrite = {})
          @built_messsage[:from_color]  = overwrite[:from_color] ||= color(:from, @options[:from])
          @built_messsage[:to_color]    = overwrite[:to_color]   ||= color(:to, @options[:to])
          @built_messsage[:prefix]      = overwrite[:prefix]     ||= Rainbow('✔').color(:green)
          @built_messsage[:block_from]  = overwrite[:block_from] ||= Rainbow('██').color("#{@built_messsage[:from_color]}")
          @built_messsage[:block_to]    = overwrite[:block_to]   ||= Rainbow('██').color("#{@built_messsage[:to_color]}")
          @built_messsage[:timestamp]   = overwrite[:timestamp]  ||= @options[:timestamp].strftime('%H:%M:%S')
          @built_messsage[:from]        = overwrite[:from]       ||= Rainbow(format_service(@options[:from])).color("#{@built_messsage[:from_color]}")
          @built_messsage[:to]          = overwrite[:to]         ||= Rainbow(format_service(@options[:to])).color("#{@built_messsage[:to_color]}")
          @built_messsage[:message]     = overwrite[:message]    ||= @options[:message]
          @built_messsage[:arrow]       = overwrite[:arrow]      ||= '→'
          @built_messsage
        end

        def log(message)
          Jarvis::Utility::Logger.message(message, log: true, view: false)
        end

        def format_service(service)
          service.upcase[0..14].strip
        end

        def color(type, name)
          case type
          when :from
            addon_type = :source
          when :to
            addon_type = :receiver
          end
          Jarvis::API::Addons.specs(addon_type, name)[addon_type.to_s]['color_message']
        end
      end
    end
  end
end
