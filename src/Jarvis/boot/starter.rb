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

  require 'Jarvis/plugins/plugins_directories'
  require 'Jarvis/plugins/plugins_registered'
  require 'Jarvis/plugins/plugin_base'
  require 'Jarvis/plugins/plugins'

  require 'Jarvis/messages/factory'
  require 'Jarvis/messages/handler'

  require 'Jarvis/utility/logger'
  require 'Jarvis/utility/viewer/log'
  require 'Jarvis/utility/viewer/message'

  require 'Jarvis/boot/plugins'
  require 'Jarvis/boot/session'
  require 'Jarvis/boot/sources'
end