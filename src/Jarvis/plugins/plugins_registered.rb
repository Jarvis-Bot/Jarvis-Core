module Jarvis
  module Plugins
    class Registered
      attr_reader :registered_plugins
      def initialize
        directories = Directories.new
        @plugins_directories = directories.plugins_directories
        @registered_plugins  = []
        load_plugins
      end

      def load_plugins
        @plugins_directories.each do |directory|
          plugin_specs_yaml = YAML.load_file(File.join(directory, 'plugin.yml'))
          plugin_specs_yaml['directory'] = directory
          @registered_plugins.push(plugin_specs_yaml)
        end
      end
    end
  end
end
