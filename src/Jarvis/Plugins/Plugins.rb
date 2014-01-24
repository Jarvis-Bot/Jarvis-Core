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

    def receive_message(message)
      if $infos.current_user != message.user
        @message = message
        if triggers_match?(message)
          call_plugin
        end
      end
    end

    private
    def triggers_match?(message)
      @registered_plugins.each do |plugin_specs_yaml|
        plugin_specs_yaml["Plugin"]["triggers"].any? do |trigger_word|
          @directory = plugin_specs_yaml["directory"]
          return message.text.downcase.include? trigger_word
        end
      end
    end

    def call_plugin
      basename = Pathname.new(@directory).basename.to_s
      require "#{@directory}init.rb"
      args_hash = {
        :message => @message
      }
      Object::const_get("#{basename}")::init(args_hash)
    end

  end
end
