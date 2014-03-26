class HelloWorld
  def self.init(args_hash)
    @tweet   = "@#{args_hash[:service_object].user.screen_name} Hello back !"
    @options = { in_reply_to_status: args_hash[:service_object] }
    send_tweet
  end

  def self.send_tweet
    Jarvis::Plugins::PluginBase.rest_client.update(@tweet, @options)
  end
end
