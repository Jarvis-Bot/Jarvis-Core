require 'fileutils'
require 'Jarvis/addons/addons'
require 'Jarvis/API/addons'
require 'Jarvis/CLI/stdio'
include Jarvis::CLI::Stdio
module Jarvis
  module CLI
    class Remove
      def initialize
        @menu_options = create_menu_options unless none_to_remove?
        @to_remove = open_menu
        remove if sure_to_remove?
      end

      def none_to_remove?
        Jarvis::Utility::Logger.error("No addons installed.", log: false) if Jarvis::API::Addons.count == 0
      end

      def create_menu_options
        menu_options = {for_user: [], for_computer: []}
        Jarvis::API::Addons.all.each do |type, addons|
          addons.validated.each do |addon|
            type        = type.to_s.chomp('s')
            name_addon  = addon[:informations]['specs']['name']
            name_author = addon[:informations]['author']['name']
            directory   = addon[:informations]['directory']
            menu_options[:for_user].push "[#{type.upcase}] #{name_addon} by #{name_author}"
            menu_options[:for_computer].push directory
          end
        end
        menu_options
      end

      def open_menu
        Stdio.pick('Which addon do you want to remove?', @menu_options[:for_user])
      end

      def sure_to_remove?
        id_to_remove = @menu_options[:for_user].index(@to_remove)
        @folder_to_remove = @menu_options[:for_computer][id_to_remove]
        say = "Are you sure to remove this addon?\nIn #{@folder_to_remove}"
        Stdio.yes?(say, color: 'red')
      end

      def remove
        puts "Removing '#{@to_remove}'..."
        if FileUtils.rm_rf(@folder_to_remove).nil?
          Stdio.not_done("Error while deleting this folder : '#{@folder_to_remove}'.")
        else
          Stdio.done
        end
      end
    end
  end
end
