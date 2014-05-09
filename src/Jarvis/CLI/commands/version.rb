module Jarvis
  module CLI
    def self.init
      major = JARVIS[:version][:major]
      minor = JARVIS[:version][:minor]
      patch = JARVIS[:version][:patch]
      pre = JARVIS[:version][:pre]

      version = [major, minor, patch, pre].compact.join('.')
      puts "Jarvis #{version}"
    end
  end
end
