module Jarvis
  class Keys
    attr_accessor :keys
    def initialize
      @keys = YAML.load_file('../config/keys.yml')
    end

    def are_defined?
      are_defined = 
        @keys["consumer_key"]        != "YOUR_CONSUMER_KEY_HERE" &&
        @keys["consumer_secret"]     != "YOUR_CONSUMER_SECRET_HERE" &&
        @keys["access_token"]        != "YOUR_ACCESS_TOKEN_HERE" &&
        @keys["access_token_secret"] != "YOUR_ACCESS_TOKEN_SECRET_HERE"
      return are_defined
    end
  end
end