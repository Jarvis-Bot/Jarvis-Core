require 'yaml'
module Jarvis
  module ThirdParty
    class ThirdParty
      def initialize(type)
        @directory = File.join('..', 'third-party', type.to_s, '*')
      end

      def is_valid?(directory)
        @specs_file = File.join(directory, 'specs.yml')
        @init_file  = File.join(directory, 'init.rb')
        File.exist?(@specs_file) && File.exist?(@init_file)
      end

      def register
        registered = []
        Dir[@directory].each do |directory|
          if self.is_valid?(directory)
            specs = YAML.load_file(@specs_file)
            specs['directory'] = directory
            registered.push specs
          end
        end
        registered
      end
    end
  end
end