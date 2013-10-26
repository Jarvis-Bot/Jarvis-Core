module Jarvis
  class Caller
    def initialize(plugins_infos, tweet, trigger_detected)
      @plugins_infos       = plugins_infos
      @tweet               = tweet 
      @trigger_detected    = trigger_detected
      @path_plugins_folder = "../plugins/"

      self.instantiate
    end

    def instantiate
      instance = Object::const_get(@plugins_infos["receiver_class_name"]).new(@tweet, @trigger_detected)
    end
  end
end