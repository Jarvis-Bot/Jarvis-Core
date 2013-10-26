module Jarvis
  class Loader
    def initialize
      lister = Lister.new
      @list_plugins = lister.list_plugins
      @list_triggers = self.list_triggers
    end

    def list_triggers
      list_triggers = Hash.new
      @list_plugins.each { |plugin|
        to_merge = {plugin["name"] => plugin["triggers"]}
        list_triggers = list_triggers.merge(to_merge)
      }
      return list_triggers
    end
  end
end