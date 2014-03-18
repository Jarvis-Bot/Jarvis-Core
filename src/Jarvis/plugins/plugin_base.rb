module Jarvis
  module Plugins
    class PluginBase
      def self.rest_client
        Sources::Twytter::REST.client
      end
    end
  end
end
