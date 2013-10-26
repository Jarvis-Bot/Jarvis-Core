module Jarvis
  class Loader
    attr_accessor :triggers_list, :plugins_full_infos_list
    def initialize
      lister = Lister.new
      @plugins_list            = lister.list_plugins
      @plugins_full_infos_list = self.index_full_infos(lister.list_full_infos_plugins)
      @triggers_list           = self.list_triggers
      self.require_plugins
    end

    def list_triggers
      list_triggers = Hash.new
      @plugins_list.each { |plugin|
        to_merge = {plugin["name"] => plugin["triggers"]}
        list_triggers = list_triggers.merge(to_merge)
      }
      return list_triggers
    end

    def index_full_infos(not_indexed_list)
      indexed_full_infos = Hash.new
      not_indexed_list.each { |plugin|
        to_merge = {plugin["name"] => plugin}
        indexed_full_infos = indexed_full_infos.merge(to_merge)
      }
      return indexed_full_infos
    end

    def require_plugins
      @plugins_full_infos_list.each { |plugin_name, plugin_infos|
        require "../plugins/" + plugin_infos["folder_name"] + "/" + plugin_infos["receiver"]
      }
    end
  end
end