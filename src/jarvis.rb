$LOAD_PATH << File.dirname(__FILE__)

require 'pp'
require 'rainbow'
require 'yaml'
require 'pathname'

module Jarvis
  unless ARGV.first.nil?
    require 'Jarvis/commands/arguments_parser'
    Commands.receive(ARGV)
  end
end
