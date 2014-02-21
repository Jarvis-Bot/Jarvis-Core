module Jarvis
  class Config
    def self.config_keys
      @keys = {}
      puts 'Enter your consumer key :'
      @keys['consumer_key'] = $stdin.gets.chomp
      puts 'Enter your consumer secret :'
      @keys['consumer_secret'] = $stdin.gets.chomp
      puts 'Enter your access token :'
      @keys['access_token'] = $stdin.gets.chomp
      puts 'Enter your access token secret :'
      @keys['access_token_secret'] = $stdin.gets.chomp

      self.write_keys
    end

    def self.write_keys
      unless Dir.exists?('../config/')
        Dir.mkdir('../config/', 0700)
      end
      File.open('../config/keys.yml', 'w') do |f|
        f.write(@keys.to_yaml)
      end
    end
  end
end
