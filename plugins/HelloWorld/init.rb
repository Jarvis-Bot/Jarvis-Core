class HelloWorld < Jarvis::Plugin
  def self.init(args_hash)
    @tweet   = "@#{args_hash[:message].user.screen_name} Hello back !"
    @options = { in_reply_to_status: args_hash[:message] }
    send_tweet
  end

  def self.send_tweet
    Jarvis::Plugin.rest_client.update(@tweet, @options)
  end
end
