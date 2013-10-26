module Jarvis
  class Answer
    def initialize(rest_client)
      @rest_client = rest_client
    end

    def reply(screen_name, text, in_reply_to_id)
      @rest_client.update('@' + screen_name + ' ' + text, {:in_reply_to_status_id => in_reply_to_id} )
    end
    
    def update(text)
      @rest_client.update(text)
    end
  end
end