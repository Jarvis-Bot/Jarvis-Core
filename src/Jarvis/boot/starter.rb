module Jarvis
  require 'Jarvis/boot/required_files'

  Boot::RequireFiles.cli_only

  unless ARGV.first.nil?
    require 'Jarvis/commands/arguments_parser'
    Commands.receive(ARGV)
  end

  Boot::RequireFiles.dependencies
  Boot::RequireFiles.jarvis_itself
  Boot::RequireFiles.booting_files

  Boot::Plugins.start
  Boot::Sources.start

end