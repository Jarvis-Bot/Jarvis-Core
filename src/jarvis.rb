$: << File.dirname(__FILE__)

require 'pp'
require 'rainbow'
require 'yaml'
require 'pathname'

module Jarvis
  unless ARGV.first.nil?
    require 'Jarvis/CLI/Config'
    require 'Jarvis/CLI/Detector'
    require 'Jarvis/CLI/Help'
    Detector.new(ARGV)
  else
    require 'twitter'
    require 'Jarvis/Display/Viewer'

    require 'Jarvis/Infos/Infos'

    require 'Jarvis/Plugins/Plugins'
    require 'Jarvis/Plugins/PluginSkeleton'

    require 'Jarvis/Twitter/Clients'
    require 'Jarvis/Twitter/Dispatcher'

    require 'Jarvis/Launcher'
    Launcher::start
  end
end
