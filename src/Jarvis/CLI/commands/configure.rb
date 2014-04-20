require 'pp'
require 'yaml'
require 'rainbow'
require 'Jarvis/CLI/stdio'
include Jarvis::CLI::Stdio
module Jarvis
  module CLI
    def self.init
      @to_config = { for_user: [], for_computer: [] }
      scan_thirdparty
      choose_configure
    end

    def self.scan_thirdparty
      Dir.glob(File.join('..', 'third-party', '**')).each do |type_dir|
        Dir[File.join(type_dir, '**')].each do |thirdparty_dir|
          @thirdparty_dir = thirdparty_dir
          add_to_config if valid?
        end
      end
    end

    def self.valid?
      @specs_file      = File.join(@thirdparty_dir, 'specs.yml')
      @init_file       = File.join(@thirdparty_dir, 'init.rb')
      @configure_file  = File.join(@thirdparty_dir, 'configure.rb')
      File.exist?(@specs_file) && File.exist?(@init_file) && File.exist?(@configure_file)
    end

    def self.add_to_config
      specs   = YAML::load_file(@specs_file)
      type    = specs['specs']['type']
      name    = specs['specs']['name']
      author  = specs['author']['name']

      @to_config[:for_user].push "[#{type.upcase}] #{name} by #{author}"
      @to_config[:for_computer].push @configure_file
    end

    def self.choose_configure
      to_configure = Stdio.pick('Which plugin would you like to configure?', @to_config[:for_user])
      id_to_configure = @to_config[:for_user].index(to_configure)
      @path_to_configure_file = @to_config[:for_computer][id_to_configure]

      start_configuration
    end

    def self.start_configuration
      require @path_to_configure_file
      Object.const_get('Configure').new
    end
  end
end
