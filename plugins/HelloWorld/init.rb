class HelloWorld < Jarvis::Plugin
  def self.init(message)
    @tweet   = "@#{message.user.screen_name} Hello back !"
    @options = {:in_reply_to_status => message}

    self.send_tweet
  end

  def self.send_tweet
    Jarvis::Plugin::rest_client.update(@tweet, @options)
  end
end
