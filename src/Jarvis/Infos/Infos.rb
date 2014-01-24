module Jarvis
  class Infos
    attr_reader :current_user
    def initialize
      @current_user = self.current_user
    end

    def current_user
      Clients::rest.verify_credentials(:include_entities => false, :skip_status => false)
    end

    def version
      major = 0
      minor = 1
      patch = 0
      pre = nil
      [major, minor, patch, pre].compact.join('.')
    end
  end
end
