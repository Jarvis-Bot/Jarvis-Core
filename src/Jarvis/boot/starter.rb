module Jarvis
  require 'Jarvis/boot/required_files'

  Boot::RequireFiles.cli_only

  unless ARGV.first.nil?
    require 'Jarvis/CLI/arguments_parser'
    CLI.receive(ARGV)
    exit
  end

  Boot::RequireFiles.dependencies
  Boot::RequireFiles.jarvis_itself
  Boot::RequireFiles.booting_files

  Boot::Plugins.start
  Boot::Sources.start

end