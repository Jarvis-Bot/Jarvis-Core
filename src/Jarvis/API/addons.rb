module Jarvis
  module API
    class Addons
      def self.specs(type, name)
        Jarvis::Boot::Session.addons_sort_by_name[format(type, 's')][format(name)]
      end

      def self.client(name)
        infos = Jarvis::Boot::Session.addons_sort_by_name[:clients][format(name)]
        require "#{infos['directory']}/init"
        Object.const_get(infos['specs']['class_name'])
      end

      def self.call_receivers_for(service)
        receivers = Jarvis::Boot::Session.receivers_sort_by_services[format(service)]
        receivers.nil? ? [] : receivers
      end

      def self.format(word, suffix = '')
        word = word.to_s
        word << suffix
        word.downcase.to_sym
      end
    end
  end
end
