module Jarvis
  class PluginSkeleton
    def self.rest_client
      Clients::rest
    end
  end
end
