module Jarvis
  class Launcher
    def self.start
      check_keys
      $infos = Infos.new
      check_plugins
      start_jarvis
    end

    def self.check_keys
      unless File.exist?('../config/keys.yml')
        puts "You need to configure Twitter API's keys in Jarvis"
        puts 'Go to http://dev.twitter.com/'
        require 'Jarvis/CLI/Config'
        Config.config_keys
      end
    end

    def self.check_plugins
      @plugins = Plugins.new
      @plugins.scan_directories
      @plugins.load_plugins
    end

    def self.start_jarvis
      Viewer.welcome_message($infos.current_user)

      Clients.stream.user(with: 'user') do |message|
        Dispatcher.dispatch(message, @plugins)
      end
    end
  end
end
