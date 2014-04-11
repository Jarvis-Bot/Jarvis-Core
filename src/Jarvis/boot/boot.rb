module Jarvis
  module Boot
    class Boot
      def initialize
        Jarvis::Boot::ThirdParty.new
      end
    end
  end
end