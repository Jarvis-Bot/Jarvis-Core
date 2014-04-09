require 'yaml'
module Jarvis
  module Receivers
    class Registered
      attr_reader :registered
      def initialize
        @registered = []
        register
      end

      def register
        Dir[File.join('..', 'third-party', 'receivers', '*')].each do |directory|
          specs_file = File.join(directory, 'specs.yml')
          init_file  = File.join(directory, 'init.rb')

          if (File.exist?(specs_file) && File.exist?(init_file))
            @registered.push YAML.load_file(specs_file)
          end
        end
      end

      def sorted
        sorted_receivers = {}
        @registered.each do |receiver|
          receiver['specs']['handle'].each do |service|
            sorted_receivers[service.to_sym] = [] unless receiver[service.to_sym].kind_of?(Array)
            sorted_receivers[service.to_sym].push receiver['specs']['name']
          end
        end
        sorted_receivers
      end
    end
  end
end