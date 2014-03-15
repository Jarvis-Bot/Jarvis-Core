module Jarvis
  module Sources
    class Keys
      def self.twitter
        YAML.load_file('../config/twitter_keys.yml')
      end
    end
  end
end
