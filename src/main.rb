require 'pp'
require 'rainbow'
require './Handler.rb'
require './Clients.rb'
require './Answer.rb'
require './Loader.rb'

# -----------------------------

## Loadings modules
loader = Loader.new()

## Connect REST and Streaming clients

clients = Hash.new()

  # REST client
  clients[:REST] = Clients.getREST
  answer = Answer.new(clients[:REST])

  # Stream client
  clients[:stream] = Clients.getStream
  clients[:stream].user(:replies => 'all') { |tweet|
    Handler.new(tweet, answer)
  }

