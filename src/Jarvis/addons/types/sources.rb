module Jarvis
  module Addons
    class Sources
      def initialize
        @sources = Jarvis::Addons::Addons.new(:sources)
        self
      end

      def load
        @threads = []
        @sources.validated.each do |source|
          require "#{source[:path]}/init"
          class_name = source[:informations]['specs']['class_name']
          @threads.push Thread.new { Object.const_get(class_name).new }
        end
      end

      def launch
        load
        @threads.each do |thread|
          thread.join
        end
      end
    end
  end
end