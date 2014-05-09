require 'octokit'
require 'open3'
require 'Jarvis/CLI/stdio'
include Jarvis::CLI::Stdio
module Jarvis
  module Boot
    class Update
      def initialize(manual_start = false)
        @path_last_update_at = File.join(JARVIS[:root], 'config', '.last_check_update_at')
        if Time.now > Time.at(last_check) + (60*60*12) || manual_start
          @manual_start = manual_start
          @octokit_client = octokit_client
          @current_version = JARVIS[:version]
          @last_stable_release = last_stable_release
          if manual_start && new_version_available?
            announce_new_version
            ask_confirm
            update_jarvis
          else
            Jarvis::Utility::Logger.info('Checking for Jarvis update...')
            announce_new_version if new_version_available?
          end
          save_update_at_file
        end
      end

      def save_update_at_file
        File.open(@path_last_update_at, 'w') do |f|
          f.write(Time.now.to_i)
        end
      end

      def last_check
        File.read(@path_last_update_at).to_i
      end

      def last_stable_release
        @octokit_client.releases(JARVIS[:repo], :per_page => 5).each do |release|
          return release if release[:prerelease] == false
        end
      end

      def octokit_client
        if defined? Jarvis::API::Profile.user.profile['tokens']['github']
          token = Jarvis::API::Profile.user.profile['tokens']['github']
          Octokit::Client.new(:access_token => token)
        else
          Octokit::Client.new
        end
      end

      def new_version_available?
        Gem::Dependency.new('Jarvis', "> #{@current_version}").match?('Jarvis', normalize_version(@last_stable_release[:tag_name]))
      end

      def normalize_version(version)
        version.gsub(/^\D+/, '')
      end

      def announce_new_version
        Jarvis::Utility::Logger.info('A new version of Jarvis is available!', color: :green) unless @manual_start
        Jarvis::Utility::Logger.info('Start Jarvis with --update to upgrade it.', color: :green) unless @manual_start
        Jarvis::Utility::Logger.info('-----------------------------------------', color: :yellow)
        Jarvis::Utility::Logger.info("Changelog of version #{@last_stable_release[:name]} :", color: :default)
        Jarvis::Utility::Logger.info("#{@last_stable_release[:body]}", color: :default)
        Jarvis::Utility::Logger.info('-----------------------------------------', color: :yellow)
      end

      def ask_confirm
        exit unless Jarvis::CLI::Stdio.yes?('Are you sure to update Jarvis?')
      end

      def update_jarvis
        to_version = @last_stable_release[:tag_name]
        git %(pull --stat origin #{to_version})
      end

      def git(command)
        %x(git #{command})
        if $?.success?
          Jarvis::CLI::Stdio.done("Jarvis has been successfully updated!")
        else
          Jarvis::CLI::Stdio.not_done("Jarvis hasn't been updated!")
        end
      end
    end
  end
end
