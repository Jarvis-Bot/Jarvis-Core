$LOAD_PATH << File.dirname(__FILE__)

module Jarvis
  require 'Jarvis/boot/constants'
  JARVIS = {}
  Boot::Constants.new
  require 'Jarvis/boot/starter'
end
