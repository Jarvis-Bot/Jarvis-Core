module Jarvis
  module Addons
    class Sources
      def initialize
        sources = Jarvis::Addons::Addons.new(:sources)
        load(sources)
        launch
      end

      def load(sources)
        @threads = []
        sources.validated.each do |source|
          require "#{source[:path]}/init"
          class_name = source[:informations]['specs']['class_name']
          @threads.push Thread.new { Object.const_get(class_name).new }
        end
      end

      def launch
        @threads.each do |thread|
          thread.join
        end
      end
    end
  end
end