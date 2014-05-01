require 'yaml'
require 'Jarvis/CLI/commands/helpers/addon_generator'
require 'Jarvis/CLI/commands/helpers/questions'
module Jarvis
  module CLI
    class AddonReceiver
      def initialize
        @receiver_generator = AddonGenerator.new(:receiver)
        intro
        fill_specs
        generate_receiver
      end

      def intro
        @receiver_generator.intro
      end

      def fill_specs
        @receiver_generator.default_specs
        @receiver_generator.ask_specific do
          receiver = Questions.new(:receiver, 'Now, I have some specific questions about your receiver.')
          receiver.ask(:service_name, "What's the name of the service used ?", "If it's a website, type the domain name without the extension, e.g: www.twitter.com = twitter")
          receiver.ask(:color_message, "Your message need some color. What's yours?", 'If the service used have some designer guideline, enter the primary color')
        end
      end

      def generate_receiver
        @receiver_generator.generate_files
      end
    end
  end
end