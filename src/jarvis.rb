$LOAD_PATH << File.join(File.dirname(__FILE__), "Jarvis")

require 'pp'
require 'rainbow'
require 'yaml'
require 'pathname'

module Jarvis
  unless ARGV.first.nil?
    require 'commands/commands'
    Commands.receive(ARGV)
  end
end
