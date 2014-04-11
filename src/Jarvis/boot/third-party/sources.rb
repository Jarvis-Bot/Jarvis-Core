module Jarvis
  module Boot
    class Sources
      def initialize
        @registered = Session.registered_sources
        load
        launch
      end

      def load
        @threads = []
        @registered.each do |source|
          require "#{source['directory']}/init"
          class_name = source['source']['class name']
          @threads.push Thread.new{Object.const_get(class_name).new}
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