class HelloWorld
  def initialize(answer_instance, tweet, trigger_detected)
    @answer           = answer_instance
    @tweet            = tweet
    @trigger_detected = trigger_detected
    self.send_back
  end

  def send_back
    @answer.reply(@tweet.user.screen_name, "Hello World !", @tweet.id)
  end
end