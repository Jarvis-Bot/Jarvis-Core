require 'yaml'
require 'Jarvis/CLI/commands/helpers/addon_generator'
require 'Jarvis/CLI/commands/helpers/questions'
module Jarvis
  module CLI
    class AddonClient
      def initialize
        @client_generator = AddonGenerator.new(:client)
        intro
        fill_specs
        generate_client
      end

      def intro
        @client_generator.intro
      end

      def fill_specs
        @client_generator.default_specs
        @client_generator.ask_specific do
          client = Questions.new(:client, 'Now, I have some specific questions about your client.')
          client.ask(:service_name, "What's the name of the service used ?", "If it's a website, type the domain name without the extension, e.g: www.twitter.com = twitter")
        end
      end

      def generate_client
        @client_generator.generate_files
      end
    end
  end
end