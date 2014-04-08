require 'yaml'
module Jarvis
  module Plugins
    class Registered
      attr_reader :registered
      def initialize
        @registered = []
        register
      end

      def register
        Dir[File.join('..', 'third-party', 'plugins', '*')].each do |directory|
          specs_file = File.join(directory, 'specs.yml')
          init_file  = File.join(directory, 'init.rb')

          if (File.exist?(specs_file) && File.exist?(init_file))
            @registered.push YAML.load_file(specs_file)
          end
        end
      end

      def sorted
        sorted_plugins = {}
        @registered.each do |plugin|
          plugin['specs']['handle'].each do |service|
            sorted_plugins[service.to_sym] = [] unless sorted_plugins[service.to_sym].kind_of?(Array)
            sorted_plugins[service.to_sym].push plugin['specs']['name']
          end
        end
        sorted_plugins
      end
    end
  end
end