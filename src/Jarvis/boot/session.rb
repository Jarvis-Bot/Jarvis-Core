require 'memoizable'
module Jarvis
  module Boot
    class Session
      class << self
        include Memoizable
        def addons
          { sources: Jarvis::Addons::Addons.new(:sources),
            clients: Jarvis::Addons::Addons.new(:clients),
            receivers: Jarvis::Addons::Addons.new(:receivers) }
        end
        memoize :addons

        def addons_sort_by_name
          sorted = {}
          addons.each do |type, addons|
            sorted[type.to_sym] = {} unless sorted[type.to_sym].is_a? Hash
            addons.validated.each do |specs|
              informations = specs[:informations]
              sorted[type.to_sym].store(informations['specs']['name'].downcase.to_sym, informations)
            end
          end
          sorted
        end
        memoize :addons_sort_by_name

        def receivers_sort_by_services
          sorted = {}
          addons[:receivers].validated.each do |receiver|
            informations = receiver[:informations]
            informations['receiver']['handle'].each do |service|
              sorted[service.to_sym] = [] unless sorted[service.to_sym].is_a? Array
              to_push = { informations['specs']['name'] => informations }
              sorted[service.to_sym].push to_push
            end
          end
          sorted
        end
        memoize :receivers_sort_by_services
      end
    end
  end
end
