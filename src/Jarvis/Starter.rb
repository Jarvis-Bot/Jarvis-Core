module Jarvis
  class Starter
    def initialize
      self.start
    end

    def start
      # Connect clients
      clients = Clients.new
      # Give ability to answer
      answer_instance = Answer.new(clients.client_REST)
      # Waiting for a tweet...
      options = {
        :replies => 'all',
        :with    => 'followings'
      }
      clients.client_stream.user(options) do |tweet|
        Handler.new(tweet, answer_instance)
      end
    end
  end
end