require 'pp'
module Jarvis
  module Commands
    def self.receive(args)
      @args = args
      @file_name = @args.shift
      @path_command_file = File.join(File.dirname(__FILE__), @file_name + ".rb")
      exec_command
    end

    def self.exec_command
      if File.exist?(@path_command_file)
        begin
          require @path_command_file
          @args.length > 0 ? Commands.send(:init, @args) : Commands.send(:init)
        rescue ArgumentError => e
          puts 'I think you forgot an argument. Take a look at the help:'
          require 'Jarvis/commands/help'
          Commands.help
        end
      else
        puts 'Woops, there is something wrong. Take a look at the help:'
        require 'Jarvis/commands/help'
        Commands.help
        abort
      end
    end
  end
end