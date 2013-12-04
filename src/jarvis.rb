$: << File.dirname(__FILE__)

require 'pp'
require 'rainbow'
require 'yaml'

module Jarvis
  unless ARGV.first.nil?
    require 'Jarvis/CLI/Config'
    require 'Jarvis/CLI/Detector'
    require 'Jarvis/CLI/Help'
    Detector.new(ARGV)
  else
    require 'twitter'
    require 'Jarvis/Config/Keys'
    require 'Jarvis/Display/Viewer'
    require 'Jarvis/Plugins/Scanner'
    require 'Jarvis/Plugins/Lister'
    require 'Jarvis/Plugins/Loader'
    require 'Jarvis/Twitter/Clients'
    require 'Jarvis/Twitter/Handler'
    require 'Jarvis/Twitter/Caller'
    require 'Jarvis/Twitter/Answer'
    require 'Jarvis/Starter'
    Starter.new
  end
end