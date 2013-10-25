require 'pp'
require 'rainbow'
require './Handler.rb'
require './Clients.rb'
require './Answer.rb'

clients = Hash.new()


# REST client
clients[:REST] = Clients.getREST
answer = Answer.new(clients[:REST])

# Stream client
clients[:stream] = Clients.getStream
clients[:stream].user(:replies => 'all') do |tweet|
  Handler.new(tweet, answer)
end