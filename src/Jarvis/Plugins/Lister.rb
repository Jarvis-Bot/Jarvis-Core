module Jarvis
  class Lister
    attr_accessor :list_plugins, :list_full_infos_plugins
    def initialize
      scanner = Scanner.new
      @plugins_directories     = scanner.plugins_directories
      @list_full_infos_plugins = self.full_infos
      @list_plugins            = self.create_list
    end

    def create_list
      list_plugins = Array.new
      @list_full_infos_plugins.each{ |plugin|
        list_plugins.push(plugin)
      }
      return list_plugins
    end

    def full_infos
      plugins_infos = Array.new

      @plugins_directories.each { |directory|
        plugins_infos.push(YAML.load_file(directory + 'plugin.yml'))
      }
      return plugins_infos
    end
  end
end