module Jarvis
  module Boot
    class RequireFiles
      def self.cli_only
        require 'yaml'
      end

      def self.jarvis_itself
        require 'rainbow'
        require 'twitter'
        require 'pathname'
        require 'Jarvis/plugins/plugins_directories'
        require 'Jarvis/plugins/plugins_registered'
        require 'Jarvis/plugins/plugin_base'
        require 'Jarvis/plugins/plugins'

        require 'Jarvis/messages/factory'
        require 'Jarvis/messages/handler'
        require 'Jarvis/messages/factories/twitter'

        require 'Jarvis/sources/keys'
        require 'Jarvis/sources/twytter/rest'
        require 'Jarvis/sources/twytter/streaming'

        require 'Jarvis/utility/logger'
        require 'Jarvis/utility/viewer/log'
        require 'Jarvis/utility/viewer/message'
      end

      def self.booting_files
        require 'Jarvis/boot/plugins'
        require 'Jarvis/boot/sources'
      end
    end
  end
end