require 'Jarvis/CLI/commands/helpers/addonsfile_parser'
module Jarvis
  module CLI
    class Install
      def initialize
        @addonsfile_path = File.join(JARVIS[:root], 'Addonsfile')
        @addons = parse_addonsfile
        install_init
      end

      def parse_addonsfile
        AddonsFileParser.new(@addonsfile_path).addons
      end

      def install_init
        @addons.each do |addon|
          case addon[:options][0]
          when :github, nil
            install_via(:github, addon)
          else
            Jarvis::Utility::Logger.error("#{addon[:options]} is not a valid option.")
          end
        end
      end

      def install_via(type, addon)
        require File.join(__dir__, 'installers', "#{type.to_s}.rb")
        Object.const_get("Jarvis::CLI::Installers::#{type.capitalize}").new(addon)
      end
    end
  end
end
