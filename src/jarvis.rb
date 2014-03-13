$LOAD_PATH << File.dirname(__FILE__)

require 'pp'
require 'rainbow'
require 'yaml'
require 'pathname'

module Jarvis
  unless ARGV.first.nil?
    require 'Jarvis/commands/commands'
    Commands.receive(ARGV)
  end
end
