require 'yaml'
module Jarvis
  module CLI
    class Profile
      attr_reader :type, :file, :path, :path_to_file
      def initialize(type)
        @type = type
        @file = "#{@type}.yml"
        @path = File.expand_path(File.join(JARVIS[:root], 'config', 'profiles'))
        @path_to_file = File.expand_path(File.join(JARVIS[:root], 'config', 'profiles', @file))
      end

      def display
        puts @profile.to_s
      end

      def exists?
        File.exist?(@path_to_file)
      end

      def load
        @profile = YAML.load_file(@path_to_file)
        rescue Errno::ENOENT => e
          Jarvis::Utility::Logger.error(e, log: false)
      end
    end
  end
end
