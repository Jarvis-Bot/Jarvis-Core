module Jarvis
  module Commands
    def self.version
      major = 0
      minor = 2
      patch = 1
      pre = nil

      version = [major, minor, patch, pre].compact.join('.')
      puts "Jarvis #{version}"
    end
  end
end
