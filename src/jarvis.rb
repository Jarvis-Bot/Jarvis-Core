$: << File.dirname(__FILE__)

require 'pp'
require 'rainbow'
require 'Jarvis/Handler.rb'
require 'Jarvis/Clients.rb'
require 'Jarvis/Answer.rb'
require 'Jarvis/Loader.rb'

# -----------------------------

## Loadings plugins
loader = Loader.new()
pp loader.pluginsDirectories
pp loader.pluginsTriggers

## Connect REST and Streaming clients

clients = Hash.new()

  # REST client, allow us to send reply
  clients[:REST] = Clients.getREST
  answer = Answer.new(clients[:REST])

  # Stream client, watching for a new tweet
  clients[:stream] = Clients.getStream
  clients[:stream].user(:replies => 'all') { |tweet|
    Handler.new(tweet, answer)
  }