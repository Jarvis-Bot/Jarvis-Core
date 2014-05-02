module Jarvis
  unless ARGV.first.nil?
    require 'Jarvis/utility/logger'
    require 'Jarvis/utility/viewer/log'
    require 'Jarvis/utility/viewer/message'
    require 'Jarvis/CLI/arguments_parser'
    begin
      CLI.receive(ARGV)
    rescue Interrupt
      puts "\n" # do nothing if the user interrupted the programm
    end
    exit
  end

  require 'Jarvis/boot/session'
  require 'Jarvis/boot/boot'

  require 'Jarvis/utility/logger'
  require 'Jarvis/utility/viewer/log'
  require 'Jarvis/utility/viewer/message'

  require 'Jarvis/messages/message'
  require 'Jarvis/messages/handler'
  begin
    Boot::Boot.new
  rescue Interrupt
    puts "\n"
  end
end
