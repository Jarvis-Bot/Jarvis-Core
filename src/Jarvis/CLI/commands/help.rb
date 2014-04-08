JARVIS_HELP = <<-EOS
Usage: ./jarvis [OPTION]
  install [username/repo_name]  install a plugin / source from github
  help                          display this message
  version                       print Jarvis version
EOS

# NOTE Keep the lenth of vanilla --help less than 25 lines!
# This is because the default Terminal height is 25 lines. Scrolling sucks
# and concision is important. If more help is needed we should start
# specialising help like the gem command does.
# NOTE Keep lines less than 80 characters! Wrapping is just not cricket.
# NOTE The reason the string is at the top is so 25 lines is easy to measure!

module Jarvis
  module CLI
    def self.init(name_long_help=nil)
      if ARGV.empty? || name_long_help.nil?
        puts JARVIS_HELP
      else
        self.call_long_help
      end
    end

    def self.help
      self.init
    end

    def self.call_long_help
      path_command_file = File.join(File.dirname(__FILE__), ARGV.first + ".rb")
      begin
        require path_command_file
        CLI.send(:long_help)
      rescue NoMethodError
        puts "I'm sorry, but this command doesn't provide any further documentation."
      end
    end
  end
end