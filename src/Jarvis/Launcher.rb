module Jarvis
  class Launcher
    def self.start
      current_user = Clients::rest.verify_credentials(:include_entities => false, :skip_status => false)
      Viewer::welcome_message(current_user)

      Clients::stream.user(:with => 'user') do |message|
        Dispatcher::dispatch(message)
      end
    end
  end
end
