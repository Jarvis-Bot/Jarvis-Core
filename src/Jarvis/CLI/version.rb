module Jarvis
  module CLI
    def self.init
      major = 0
      minor = 2
      patch = 1
      pre = nil

      version = [major, minor, patch, pre].compact.join('.')
      puts "Jarvis #{version}"
    end
  end
end
