class HelloWorld
  def initialize(args)
    @answer           = args[:answer_instance]
    @tweet            = args[:tweet]
    @trigger_detected = args[:trigger_detected]
    self.send_back
  end

  def send_back
    @answer.reply(@tweet.user.screen_name, "Hello World !", @tweet.id)
  end
end