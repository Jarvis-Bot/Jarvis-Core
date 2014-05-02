$LOAD_PATH << File.dirname(__FILE__)

module Jarvis
  JARVIS = {}
  JARVIS[:root] = File.expand_path(File.join('..'))
  require 'Jarvis/boot/starter'
end
