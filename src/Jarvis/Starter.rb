module Jarvis
  class Starter
    def initialize
      self.start
    end

    def start
      loader = Loader.new
      @triggers_list = loader.triggers_list
      
    end
  end
end