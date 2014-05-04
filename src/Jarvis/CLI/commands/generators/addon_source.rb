require 'yaml'
require 'Jarvis/CLI/commands/helpers/addon_generator'
require 'Jarvis/CLI/commands/helpers/questions'
module Jarvis
  module CLI
    class AddonSource
      def initialize
        @source_generator = AddonGenerator.new(:source)
        intro
        fill_specs
        generate_source
      end

      def intro
        @source_generator.intro
      end

      def fill_specs
        @source_generator.default_specs
        @source_generator.ask_specific do
          source = Questions.new(:source, 'Now, I have some specific questions about your source.')
          source.ask(:service_name, "What's the name of the service used ?", "If it's a website, type the domain name without the extension, e.g: www.twitter.com = twitter")
          source.ask(:color_message, "Your message need some color. What's yours?", 'If the service used have some designer guideline, enter the primary color')
        end
      end

      def generate_source
        @source_generator.generate_files
      end
    end
  end
end
