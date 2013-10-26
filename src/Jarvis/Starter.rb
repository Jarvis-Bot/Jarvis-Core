module Jarvis
  class Starter
    def initialize
      self.start
    end

    def start
      # Connect clients
      clients = Clients.new
      clients.client_stream.user(:replies => 'all') do |tweet|
        Handler.new(tweet)
      end
    end
  end
end