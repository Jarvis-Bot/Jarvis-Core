module Jarvis
  module Plugins
    class Directories
      attr_reader :plugins_directories
      def initialize
        @plugins_directories = []
        scan_directories
      end

      def scan_directories
        Dir['/media/www-dev/private/ruby/Jarvis/plugins/*/'].each do |directory|

          plugin_yml_exists = File.exist?(File.join(directory, 'plugin.yml'))
          init_rb_exists    = File.exist?(File.join(directory, 'init.rb'))

          if (plugin_yml_exists && init_rb_exists)
            @plugins_directories.push(directory)
          end

        end
      end
    end
  end
end
