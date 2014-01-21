module Jarvis
  class Plugins
    def initialize
      @registered_plugins   = {}
      @plugins_directories  = Array.new
      scan_directories
      load_plugins
      require "pp"
      pp @registered_plugins
    end

    def scan_directories
      Dir['../plugins/*/'].each do |directory|
        @plugins_directories.push(directory)
      end
    end

    def load_plugins
      @plugins_directories.each do |directory|
        initializer = File.join(directory, "init.rb")
        if File.file?(initializer)
          require initializer
          pp Test.new.author
        end
      end
    end
  end
end

module Jarvis
  require "pp"
  plugins = Plugins.new
end
