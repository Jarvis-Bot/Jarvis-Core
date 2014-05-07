module Jarvis
  module CLI
    class AddonsFileParser
      attr_reader :addons
      def initialize(addonsfile)
        @addons = []
        @addonsfile = addonsfile
        eval_addonsfile
      end

      def eval_addonsfile
        @contents ||= File.open(@addonsfile, 'rb') { |f| f.read }
        instance_eval(@contents)
      end

      def addon(name, version, *options)
        addon = { name: name, version: version, options: options }
        @addons.push addon
      end
    end
  end
end
