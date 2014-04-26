require 'memoizable'
module Jarvis
  module Boot
    class Session
      class << self
        include Memoizable
        def registered_receivers
          receivers ||= Jarvis::ThirdParty::ThirdParty.new(:receivers)
          receivers.register
        end
        memoize :registered_receivers

        def sorted_registered_receivers
          sorted = {}
          custom_specs = {}
          registered_receivers.each do |receiver|
            receiver['receiver']['handle'].each do |service|
              sorted[service.to_sym] = [] unless sorted[service.to_sym].kind_of?(Array)
              custom_specs = {
                name: receiver['specs']['name'],
                directory: receiver['directory'],
                class_name: receiver['receiver']['class name']
              }
              sorted[service.to_sym].push custom_specs
            end
          end
          sorted
        end
        memoize :sorted_registered_receivers

        def registered_sources
          sources ||= Jarvis::ThirdParty::ThirdParty.new(:sources)
          sources.register
        end
        memoize :registered_sources

        def registered_clients
          clients ||= Jarvis::ThirdParty::ThirdParty.new(:clients)
          clients.register
        end
        memoize :registered_clients

        def all_sorted
          sources = {}
          registered_sources.each do |source|
            sources.store(source['specs']['name'].downcase.to_sym, source)
          end
          clients = {}
          registered_clients.each do |client|
            clients.store(client['specs']['name'].downcase.to_sym, client)
          end
          receivers = {}
          registered_receivers.each do |receiver|
            receivers.store(receiver['specs']['name'].downcase.to_sym, receiver)
          end
          { sources: sources, receivers: receivers, clients: clients }
        end
        memoize :all_sorted
      end
    end
  end
end
