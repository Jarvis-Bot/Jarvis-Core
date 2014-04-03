JARVIS_HELP = <<-EOS
Usage: ./jarvis [OPTION]
  help                     display this message
  version                  print Jarvis version
EOS

# NOTE Keep the lenth of vanilla --help less than 25 lines!
# This is because the default Terminal height is 25 lines. Scrolling sucks
# and concision is important. If more help is needed we should start
# specialising help like the gem command does.
# NOTE Keep lines less than 80 characters! Wrapping is just not cricket.
# NOTE The reason the string is at the top is so 25 lines is easy to measure!

module Jarvis
  module Commands
    def self.init
      puts JARVIS_HELP
    end

    def self.help
      self.init
    end
  end
end
