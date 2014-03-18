module Jarvis
  module Boot
    Utility::Logger.info('Scanning plugins directory...')
    loaded_plugins = Plugins::Plugins.load
    loaded_plugins.each do |plugin|
      Utility::Logger.info("\"#{plugin['Plugin']['name']}\" by \"#{plugin['Author']['name']}\" loaded.")
    end
    Utility::Logger.info("Total : #{loaded_plugins.count} plugin(s) loaded.")
  end
end