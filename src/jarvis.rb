$: << File.dirname(__FILE__)

require 'pp'
require 'rainbow'
require 'yaml'

JARVIS_HELP = <<-EOS
Usage: ./jarvis [OPTION]
  -c, --configure          configure Jarvis with Twitter API keys
  -h, --help               display this message
EOS

case ARGV.first
when "-h", "--help", "help"
  puts JARVIS_HELP
when "-c" , "--configure", "configure"
  keys = Hash.new
  puts "Enter your consumer key :"
  keys["consumer_key"] = $stdin.gets.chomp
  puts "Enter your consumer secret :"
  keys["consumer_secret"] = $stdin.gets.chomp
  puts "Enter your access token :"
  keys["access_token"] = $stdin.gets.chomp
  puts "Enter your access token secret :"
  keys["access_token_secret"] = $stdin.gets.chomp

  File.open("../config/keys.yml", "w") { |f|
    f.write(keys.to_yaml)
  }
when nil

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