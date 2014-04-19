JARVIS_HELP = <<-EOS
Usage: ./jarvis [OPTION]
  install USERNAME/REPO_NAME    install a receiver / source from github
  help [command]                display this message / help for this command
  version                       print Jarvis version
EOS

# NOTE Keep the lenth of vanilla help less than 25 lines!
# This is because the default Terminal height is 25 lines. Scrolling sucks
# and concision is important.
# NOTE Keep lines less than 80 characters! Wrapping is just not cricket.
# NOTE The reason the string is at the top is so 25 lines is easy to measure!

module Jarvis
  module CLI
    def self.init(name_long_help = nil)
      if ARGV.empty? || name_long_help.nil?
        puts JARVIS_HELP
      else
        call_long_help
      end
    end

    def self.help
      init
    end

    def self.call_long_help
      @path_command_file = File.join(File.dirname(__FILE__), ARGV.first + '.rb')
      if File.exist?(@path_command_file)
        find_long_help
      else
        puts "Hmm, this command doesn't exist. Take a look a the help:"
        require 'Jarvis/CLI/commands/help'
        CLI.help
        abort
      end
    end

    def self.find_long_help
      require @path_command_file
      CLI.send(:long_help)
    rescue NoMethodError
      puts "I'm sorry, but this command doesn't provide any further documentation."
    end
  end
end
