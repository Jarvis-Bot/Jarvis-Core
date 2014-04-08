module Jarvis

  unless ARGV.first.nil?
    require 'Jarvis/utility/logger'
    require 'Jarvis/utility/viewer/log'
    require 'Jarvis/utility/viewer/message'
    require 'Jarvis/CLI/arguments_parser'
    begin
      CLI.receive(ARGV)
    rescue Interrupt => e
      puts "\n" # do nothing if the user interrupted the programm
    end
    exit
  end

  require 'Jarvis/utility/logger'
  require 'Jarvis/utility/viewer/log'
  require 'Jarvis/utility/viewer/message'

  require 'Jarvis/plugins/registered_plugins'

  require 'Jarvis/messages/message'
  require 'Jarvis/messages/handler'

end