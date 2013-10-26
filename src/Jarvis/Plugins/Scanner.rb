module Jarvis
  class Scanner
    attr_accessor :plugins_directories
    def initialize
      @plugins_directories = self.scan_plugins_directories
    end

    def scan_plugins_directories
      plugins_directories = Array.new

      Dir['../plugins/*/'].each { |directory|
        plugins_directories.push(directory)
      }
      return plugins_directories
    end
  end
end

