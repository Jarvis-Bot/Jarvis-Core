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

  require 'Jarvis/addons/addons'
  require 'Jarvis/addons/types/clients'
  require 'Jarvis/addons/types/receivers'
  require 'Jarvis/addons/types/sources'

  require 'Jarvis/boot/boot'

  require 'Jarvis/messages/message'
  require 'Jarvis/messages/handler'

  require 'Jarvis/utility/viewer/log'
  require 'Jarvis/utility/viewer/message'
  require 'Jarvis/utility/logger'
  begin
    Boot::Boot.new
  rescue Interrupt
    puts "\n"
  end
end
