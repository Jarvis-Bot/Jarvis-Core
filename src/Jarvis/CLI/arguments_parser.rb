module Jarvis
  module CLI
    def self.receive(args)
      @args = args
      @file_name = @args.shift
      @path_command_file = File.join(File.dirname(__FILE__), 'commands', @file_name + '.rb')
      exec_command
    end

    def self.exec_command
      if File.exist?(@path_command_file)
        start_command
      else
        help_message
      end
    end

    def self.start_command
      require @path_command_file
      @args.length > 0 ? CLI.send(:init, @args) : CLI.send(:init)
    rescue ArgumentError
      puts 'I think you forgot an argument. Take a look at the help:'
      require 'Jarvis/CLI/commands/help'
      CLI.help
    end

    def self.help_message
      puts 'Woops, there is something wrong. Take a look at the help:'
      require 'Jarvis/CLI/commands/help'
      CLI.help
      abort
    end
  end
end
