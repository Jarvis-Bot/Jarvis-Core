module Jarvis
  module Commands
    def self.receive(args)
      @args = args
      @file_name = "#{@args.pop}"
      @path = File.join(@args.each { |arg| arg })
      @path_command_file = File.join(File.dirname(__FILE__), @path, @file_name + ".rb")
      exec_command
    end

    def self.exec_command
      if File.exist?(@path_command_file)
        require @path_command_file
        if @args.count > 0
          @args.each do |arg|
            (defined?(@current_scope)) ?
              (@current_scope = @current_scope.const_get(arg.to_s.capitalize))
            : (@current_scope = Commands.const_get(arg.to_s.capitalize))
          end
          @current_scope.send(@file_name)
        else
          Commands.send(@file_name)
        end
      else
        puts 'Woops, there is something wrong. Take a look at the help :'
        require 'Jarvis/commands/help'
        Commands.help
        abort
      end
    end
  end
end


