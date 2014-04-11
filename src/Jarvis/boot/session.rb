require 'memoizable'
module Jarvis
  module Boot
    class Session
      class << self
        include Memoizable
        def registered_receivers
          receivers ||= Jarvis::ThirdParty::ThirdParty.new(:receivers)
          registered = receivers.register
        end
        memoize :registered_receivers

        def sorted_registered_receivers
          sorted = {}
          custom_specs = {}
          registered_receivers.each do |receiver|
            receiver['specs']['handle'].each do |service|
              sorted[service.to_sym] = [] unless sorted[service.to_sym].kind_of?(Array)
              custom_specs = {
                :directory => receiver['directory'],
                :class_name => receiver['receiver']['class name'],
              }
              sorted[service.to_sym].push custom_specs
            end
          end
          sorted
        end
        memoize :sorted_registered_receivers

        def registered_sources
          sources ||= Jarvis::ThirdParty::ThirdParty.new(:sources)
          registered = sources.register
        end
        memoize :registered_sources
      end
    end
  end
end