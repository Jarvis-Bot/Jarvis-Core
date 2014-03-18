module Jarvis
  module Messages
    class Handler
      def initialize(factory_instance)
        @factory_instance = factory_instance
        @message = factory_instance.message
        @service_object = factory_instance.service_object
        @loaded_plugins = Plugins::Plugins.load
        distribute(factory_instance.from)
      end

      def distribute(service_name)
        if message_match?
          case service_name
          when :twitter
            puts "hello"
            call_plugin
          end
        end
      end

      def message_match?
        words = @message.downcase.split(' ')
        @loaded_plugins.each do |plugin_specs_yaml|
          plugin_specs_yaml['Plugin']['triggers'].each do |trigger_word|
            if words.include?(trigger_word)
              @directory = plugin_specs_yaml['directory']
              return true
            end
          end
        end
        return false
      end

      def call_plugin
        basename = Pathname.new(@directory).basename.to_s
        require "#{@directory}init.rb"
        args_hash = {
          service_object: @service_object
        }
        Object.const_get("#{basename}").init(args_hash)
      end
    end
  end
end