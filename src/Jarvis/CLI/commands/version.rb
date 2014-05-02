module Jarvis
  module CLI
    def self.init
      major = 1
      minor = 4
      patch = 2
      pre = nil

      version = [major, minor, patch, pre].compact.join('.')
      puts "Jarvis #{version}"
    end
  end
end
