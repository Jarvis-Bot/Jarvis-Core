$: << File.dirname(__FILE__)

require 'pp'
require 'rainbow'
require 'yaml'

require 'Jarvis/Display/Viewer'

require 'Jarvis/Plugins/Scanner'
require 'Jarvis/Plugins/Lister'
require 'Jarvis/Plugins/Loader'

require 'Jarvis/Twitter/Answer'
require 'Jarvis/Twitter/Clients'
require 'Jarvis/Twitter/Handler'

module Jarvis
  loader = Loader.new
end