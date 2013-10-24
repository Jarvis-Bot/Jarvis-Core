class Keys 
  @keys = {
    consumer_key: 'YOUR_CONSUMER_KEY_HERE',
    consumer_secret: 'YOUR_CONSUMER_SECRET_HERE',
    access_token: 'YOUR_OAUTH_TOKEN_HERE',
    access_token_secret: 'YOUR_OAUTH_TOKEN_SECRET_HERE'
  }
  def self.getKeys
    return @keys
  end
end