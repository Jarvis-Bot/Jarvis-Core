module Jarvis
  class Caller
    def initialize(answer_instance, plugins_infos, tweet, trigger_detected)
      @plugins_infos       = plugins_infos

      @args = {
        :answer_instance  => answer_instance,
        :tweet            => tweet,
        :trigger_detected => trigger_detected
      }
      self.call_plugin
    end

    def call_plugin
      Object::const_get(@plugins_infos["receiver_class_name"]).new(@args)
    end
  end
end