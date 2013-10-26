module Jarvis
  class Caller
    def initialize(answer_instance, plugins_infos, tweet, trigger_detected)
      @answer_instance     = answer_instance
      @plugins_infos       = plugins_infos
      @tweet               = tweet 
      @trigger_detected    = trigger_detected
      @path_plugins_folder = "../plugins/"

      self.call_plugin
    end

    def call_plugin
      Object::const_get(@plugins_infos["receiver_class_name"]).new(@answer_instance, @tweet, @trigger_detected)
    end
  end
end