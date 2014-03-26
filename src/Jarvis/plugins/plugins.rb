module Jarvis
  module Plugins
    class Plugins
      def self.load
        directories = Directories.new
        @plugins_directories = directories.plugins_directories
        registered = Registered.new(@plugins_directories)
        @registered_plugins = registered.registered_plugins
        @registered_plugins
      end
    end
  end
end
