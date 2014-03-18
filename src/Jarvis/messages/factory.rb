module Jarvis
  module Messages
    class Factory
      def initialize(service_name)
        @timestamp = Time.now
        @from = service_name.to_sym
      end
    end
  end
end
