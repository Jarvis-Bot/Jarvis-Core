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

  require 'Jarvis/receivers/registered'

  require 'Jarvis/messages/message'
  require 'Jarvis/messages/handler'

  services_name = %w|twitter facebook web github instagram email|

  messages = [
  "Craft beer salvia tousled",
  "pug polaroid cray bitters whatever",
  "Jean shorts post-ironic hashtag drinking vinegar Etsy",
  "street art Truffaut 8-bit Intelligentsia selfies",
  "slow-carb Pinterest deep v kitsch artisan",
  "Craft beer Etsy messenger bag cornhole direct trade",
  "you probably haven't heard of them Godard lo-fi literally",
  "McSweeney's Cosby sweater letterpress 3 wolf moon",
  "Brooklyn cred. Banksy viral gastropub mlkshk church-key",
  "hella put a bird on it sriracha irony pop-up Marfa"
  ]

  while true do
    service = services_name[rand(services_name.count)]
    message = messages[rand(services_name.count)]

    Messages::Message.new(service, message)

    sleep 0.5
  end

end