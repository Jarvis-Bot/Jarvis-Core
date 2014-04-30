require 'yaml'
module Jarvis
  module CLI
    class Profile
      def initialize(type)
        @type = type
        @file = "#{@type.to_s}.yml"
        @path = File.expand_path(File.join('..', 'config', 'profiles', @file))
      end

      def display
        puts @profile.to_s
      end

      def exists?
        File.exists?(@path)
      end

      def load
        @profile = YAML.load_file(@path)
        rescue Errno::ENOENT => e
          Jarvis::Utility::Logger.error(e, log: false)
      end
    end
  end
end