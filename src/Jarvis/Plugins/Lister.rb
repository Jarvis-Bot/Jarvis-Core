module Jarvis
  class Lister
    attr_accessor :list_plugins
    def initialize
      scanner = Scanner.new
      @plugins_directories = scanner.plugins_directories
      @plugins_infos       = self.get_infos
      @list_plugins        = self.create_list
    end

    def create_list
      list_plugins = Array.new
      @plugins_infos.each{ |plugin|
        list_plugins.push(plugin)
      }
      return list_plugins
    end

    def get_infos
      plugins_infos = Array.new

      @plugins_directories.each { |directory|
        plugins_infos.push(YAML.load_file(directory + 'plugin.yml'))
      }
      return plugins_infos
    end
  end
end