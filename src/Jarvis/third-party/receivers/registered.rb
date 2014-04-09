require 'yaml'
module Jarvis
  module ThirdParty
    module Receivers
      class Registered
        attr_reader :registered
        def initialize
          @registered = []
          register
        end

        def register
          Dir[File.join('..', 'third-party', 'receivers', '*')].each do |directory|
            if ThirdParty.is_valid?(directory)
              @registered.push YAML.load_file(specs_file)
            end
          end
        end

        def sorted
          sorted_receivers = {}
          @registered.each do |receiver|
            receiver['specs']['handle'].each do |service|
              sorted_receivers[service.to_sym] = [] unless receiver[service.to_sym].kind_of?(Array)
              sorted_receivers[service.to_sym].push receiver['specs']['name']
            end
          end
          sorted_receivers
        end
      end
    end
  end
end