module Jarvis
  class Loader
    attr_accessor :triggers_list
    def initialize
      lister = Lister.new
      @plugins_list = lister.list_plugins
      @triggers_list = self.list_triggers
    end

    def list_triggers
      list_triggers = Hash.new
      @plugins_list.each { |plugin|
        to_merge = {plugin["name"] => plugin["triggers"]}
        list_triggers = list_triggers.merge(to_merge)
      }
      return list_triggers
    end
  end
end