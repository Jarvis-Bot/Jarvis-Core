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
        :with => 'user',
      }
      clients.client_stream.user(options) do |tweet|
        handler = Handler.new(tweet, answer_instance)
        viewer  = Viewer.new(tweet, handler)
        viewer.display
      end
    end
  end
end