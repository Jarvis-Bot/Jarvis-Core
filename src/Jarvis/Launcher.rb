module Jarvis
  class Launcher
    def self.start
      unless File.exist?("../config/keys.yml")
        puts "You need to configure Twitter API's keys in Jarvis. Go to http://dev.twitter.com/"
        require 'Jarvis/CLI/Config'
        Config::config_keys
      end
      self.start_jarvis
    end

    def self.start_jarvis
      # Need SSL bugfix
      # current_user = Clients::rest.verify_credentials(:include_entities => false, :skip_status => false)
      # Viewer::welcome_message(current_user)

      Clients::stream.user(:with => 'user') do |message|
        Dispatcher::dispatch(message)
      end
    end
  end
end
