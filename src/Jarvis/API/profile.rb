require 'Jarvis/boot/session'
module Jarvis
  module API
    class Profile
      def self.type(type)
        Jarvis::Boot::Session.profile[type]
      end

      def self.developer
        Jarvis::Boot::Session.profile[:developer]
      end

      def self.user
        Jarvis::Boot::Session.profile[:user]
      end
    end
  end
end
