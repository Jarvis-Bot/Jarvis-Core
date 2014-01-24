class HelloWorld < Jarvis::PluginSkeleton
  def self.init(message)
    Jarvis::PluginSkeleton::rest_client.update("Hello back !", :in_reply_to_status => message)
  end
end
