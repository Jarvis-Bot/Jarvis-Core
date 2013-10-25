class Answer
  def initialize(rest_client)
    @rest_client = rest_client
  end
  

  def byMention(screen_name, text, id)
    @rest_client.update('@' + screen_name + ' ' + text, {:in_reply_to_status_id => id} )
  end
  
end