module Jarvis
  module Boot
    class Plugins
      def self.start
        Jarvis::Utility::Logger.info('Scanning plugins directory...')
        loaded_plugins = Jarvis::Plugins::Plugins.load
        loaded_plugins.each do |plugin|
          Jarvis::Utility::Logger.info("\"#{plugin['Plugin']['name']}\" by \"#{plugin['Author']['name']}\" loaded.")
        end
        Jarvis::Utility::Logger.info("Total : #{loaded_plugins.count} plugin(s) loaded.")
      end
    end
  end
end