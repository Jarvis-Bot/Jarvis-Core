require 'yaml'
module Jarvis
  module Addons
    class Addons
    attr_reader :type, :path, :validated
      def initialize(type)
        @type = type
        @path = File.join(JARVIS[:root], 'addons', @type.to_s)
        @validated = validated
      end

      def validated
        @validated = []
        Dir.glob(File.join(@path, '*')) do |addon_dir|
          @addon_dir = addon_dir
          if valid?
            addon = {}
            addon[:path] = @addon_dir
            addon[:informations] = full_specs
            addon[:informations]['directory'] = @addon_dir
            @validated.push addon
          end
        end
        @validated
      end

      def valid?
        File.exist?(File.join(@addon_dir, 'specs.yml')) &&
        File.exist?(File.join(@addon_dir, 'init.rb'))
      end

      def full_specs
        YAML.load_file(File.join(@addon_dir, 'specs.yml'))
      end

      def count
        @validated.count
      end

      def display_count
        Jarvis::Utility::Logger.info("#{count} #{type.capitalize} installed.")
        @validated.each_with_index  do |addon, index|
          tree_char = (index + 1 == count) ? '└' : '├'
          author = addon[:informations]['author']['name']
          name = addon[:informations]['specs']['name']
          version = addon[:informations]['specs']['version']
          Utility::Logger.info("#{tree_char}───[#{name}][#{version}] by #{author}.")
        end
        count
      end
    end
  end
end