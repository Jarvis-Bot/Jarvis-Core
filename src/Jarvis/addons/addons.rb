require 'yaml'
require 'digest'
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
          @full_specs = full_specs
          if valid?
            addon = {}
            addon[:path] = @addon_dir
            addon[:informations] = @full_specs
            add_color_to addon if color_undefined_in addon
            addon[:informations]['directory'] = @addon_dir
            @validated.push addon
          end
        end
        @validated
      end

      def valid?
        File.exist?(File.join(@addon_dir, 'specs.yml')) &&
        File.exist?(File.join(@addon_dir, 'init.rb')) &&
        @full_specs['specs']['name'] &&
        @full_specs['specs']['class_name'] &&
        @full_specs['specs']['type'] &&
        @full_specs[@type.to_s.chomp('s')]
      end

      def full_specs
        YAML.load_file(File.join(@addon_dir, 'specs.yml'))
      end

      def add_color_to(addon)
        name = addon[:informations]['specs']['name']
        md5_name = Digest::MD5.hexdigest name
        color = "#{md5_name[0..5].upcase}"
        addon[:informations][@type.to_s.chomp('s')]['color_message'] = color
        addon
      end

      def color_undefined_in(addon)
        addon[:informations][@type.to_s.chomp('s')]['color_message'].nil?
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
