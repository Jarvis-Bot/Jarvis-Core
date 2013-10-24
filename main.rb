require 'pp'
require 'rainbow'
require './Handler.rb'
require './Clients.rb'

client = Clients.getStream
client.user(:replies => 'all') do |tweet|
  Handler.new(tweet)
end