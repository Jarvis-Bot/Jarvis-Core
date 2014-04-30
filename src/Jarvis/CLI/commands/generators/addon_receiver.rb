require 'yaml'
require 'Jarvis/CLI/commands/helpers/addon_generator'
require 'Jarvis/CLI/commands/helpers/questions'
module Jarvis
  module CLI
    class AddonReiceiver
      def initialize
        @reiceiver_generator = AddonGenerator.new(:reiceiver)
        intro
        fill_specs
        generate_reiceiver
      end

      def intro
        @reiceiver_generator.intro
      end

      def fill_specs
        @reiceiver_generator.default_specs
        @reiceiver_generator.ask_specific do
          reiceiver = Questions.new(:reiceiver, 'Now, I have some specific questions about your reiceiver.')
          reiceiver.ask(:service_name, "What's the name of the service used ?", "If it's a website, type the domain name without the extension, e.g: www.twitter.com = twitter")
          reiceiver.ask(:color_message, "Your message need some color. What's yours?", 'If the service used have some designer guideline, enter the primary color')
        end
      end

      def generate_reiceiver
        @reiceiver_generator.generate_files
      end
    end
  end
end