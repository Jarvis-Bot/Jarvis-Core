class Handler
  def initialize(tweet)
    @tweet = tweet
    self.display
  end

  def display
    prefix      = self.createPrefix + ' '
    screen_name = @tweet.user.screen_name.foreground(:cyan)
    name        = ' [' + @tweet.user.name.foreground(:yellow) + ']: '
    text        = @tweet.text.bright

    # ████ @PSEUDO [REALNAME]: This is a tweet
    prettyTweet = prefix + screen_name + name + text
    puts prettyTweet
  end

  def match
    if @tweet.text.include? 'test'
      return true
    else
      return false
    end
  end

  def isWhiteListed?(id_user)
    whiteList =  {14750895 => 'DarylKiley'}
    return whiteList.has_key? id_user
  end

  def createPrefix
    prefix = {}
    if isWhiteListed?(@tweet.user.id)
      prefix[:first] = '██'.foreground(:green)
    else
      prefix[:first] = '██'.foreground(:red)
    end

    if self.match
      prefix[:second] = '██'.foreground(:green)
    else
      prefix[:second] = '██'.foreground(:red)
    end

    return prefix[:first] + prefix[:second]
  end
end