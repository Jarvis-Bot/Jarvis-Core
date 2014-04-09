require 'yaml'
module Jarvis
  module ThirdParty
    def self.is_valid?(directory)
      specs_file = File.join(directory, 'specs.yml')
      init_file  = File.join(directory, 'init.rb')

      File.exist?(specs_file) && File.exist?(init_file)
    end
  end
end