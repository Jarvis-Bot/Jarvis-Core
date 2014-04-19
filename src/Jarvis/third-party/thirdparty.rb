require 'yaml'
require 'digest'
module Jarvis
  module ThirdParty
    class ThirdParty
      def initialize(type)
        @directory = File.join('..', 'third-party', type.to_s, '*')
      end

      def valid_thirdparty?(directory)
        @specs_file = File.join(directory, 'specs.yml')
        @init_file  = File.join(directory, 'init.rb')
        File.exist?(@specs_file) && File.exist?(@init_file)
      end

      def register
        registered = []
        Dir[@directory].each do |directory|
          if valid_thirdparty?(directory)
            @specs = YAML.load_file(@specs_file)
            @specs['directory'] = directory
            check_color
            registered.push @specs
          end
        end
        registered
      end

      def check_color
        generate_color if @specs['specs']['color message'].nil?
      end

      def generate_color
        name = @specs['specs']['name']
        md5_name = Digest::MD5.hexdigest name
        color = "##{md5_name[0..5].upcase}"
        @specs['specs']['color message'] = color
      end
    end
  end
end
