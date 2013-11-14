$: << File.dirname(__FILE__)

JARVIS_HELP = <<-EOS
Usage: ./jarvis [OPTION]
  -c, --configure          configure Jarvis with Twitter API keys
  -h, --help               display this message
EOS

case ARGV.first
when "-h", "--help", "help"
  puts JARVIS_HELP
when "-c" , "--configure", "configure"
  puts ""
when nil
  require 'pp'
  require 'rainbow'
  require 'yaml'
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
  module Jarvis
    Starter.new
  end
else
  puts "Woops, there is something wrong. Take a look at the help :"
  puts JARVIS_HELP
end