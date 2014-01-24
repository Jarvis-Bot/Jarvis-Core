module Jarvis
  class Infos
    attr_reader :current_user
    def initialize
      @current_user = self.current_user
    end

    def current_user
      Clients::rest.verify_credentials(:include_entities => false, :skip_status => false)
    end

  end
end
