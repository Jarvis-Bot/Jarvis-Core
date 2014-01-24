module Jarvis
  class Plugins
    def initialize
      @registered_plugins  = Array.new
      @plugins_directories = Array.new
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
          plugin_specs_yaml = YAML.load_file(directory + 'plugin.yml')
          plugin_specs_yaml["directory"] = directory
          @registered_plugins.push(plugin_specs_yaml)
          Viewer::plugin_init(plugin_specs_yaml)
        end
      end
      Viewer::plugin_count(@registered_plugins.length)
    end

    def send_message(message)
      triggers_match?(message.text)
    end

    private
    def triggers_match?(tweet)
      @registered_plugins.each do |plugin_specs_yaml|
        plugin_specs_yaml["Plugin"]["triggers"].any? do |trigger_word|
          call_plugin(plugin_specs_yaml["directory"])
          return tweet.downcase.include? trigger_word
        end
      end
    end

    def call_plugin(directory)
      basename = Pathname.new(directory).basename.to_s
      require "#{directory}init.rb"
      Object::const_get("#{basename}")::init
    end

  end
end
