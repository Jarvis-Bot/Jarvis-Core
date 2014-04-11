module Jarvis
  module Boot
    class ThirdParty
      def initialize
        @types = [:receivers, :sources]
        counting
        display
      end

      def counting
        @counted = {}
        @types.each do |type|
          type = type.to_s
          registered = Session.send("registered_#{type}")
          if registered.count <= 1
            type.chomp!('s')
          elsif registered.count == 0
            Utility::Logger.error("You must have one #{type} at least to start Jarvis.", :block => false, :log => true)
          end
          @counted[type.to_sym] = {:count => registered.count, :registered => registered}
        end
      end

      def display
        @counted.each do |type, registered|
          count = registered[:count]
          Utility::Logger.info("#{count} #{type.capitalize} installed.")
          registered[:registered].each_with_index do |specs, index|
            tree_char = (index + 1 == count) ? '└' : '├'
            Utility::Logger.info("#{tree_char}───[#{specs['author']['name']}] #{specs['specs']['name']}.")
          end
        end
      end
    end
  end
end