module Jarvis
  class Help
    def self.display_help
      jarvis_help = <<-EOS
Usage: ./jarvis [OPTION]
  -c, --configure          configure jarvis with Twitter API keys
  -h, --help               display this message
      EOS
      puts jarvis_help
    end

    def self.display_something_wrong
      puts 'Woops, there is something wrong. Take a look at the help :'
      display_help
    end
  end
end
