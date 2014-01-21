module Jarvis
  class Plugins
    def initialize
      @registered_plugins   = {}
      @plugins_directories  = Array.new
    end

    def scan_directories
      Dir['../plugins/*/'].each do |directory|
        @plugins_directories.push(directory)
      end
    end

    def load_plugins
      @plugins_directories.each do |directory|
        yaml_file = File.join(directory, "plugin.yml")
        if File.exists?(yaml_file)
          plugin_YAML = YAML.load_file(directory + 'plugin.yml')
          Viewer::plugin_init(plugin_YAML)
        end
      end
    end
  end
end
