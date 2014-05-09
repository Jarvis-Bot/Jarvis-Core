require 'rainbow'
require 'yaml'
require 'Jarvis/CLI/commands/helpers/questions'
require 'Jarvis/CLI/commands/helpers/profile'
require 'Jarvis/CLI/stdio'
module Jarvis
  module CLI
    class ProfileUser
      def initialize
        @profile_dev = Jarvis::CLI::Profile.new(:user)
        intro
        questions
      end

      def intro
        puts Rainbow('Welcome in the generator of user profile!').color(:green)
        puts Rainbow('This profile will be used by Jarvis and his addons.').color(:green)
        puts Rainbow('Your data will be stored in config/profiles/user.yml').color(:green)
        print "\n"
      end

      def questions
        @user = Questions.new(:user, 'This is about you.')
        @user.ask(:first_name, "What's your first name?")
        @user.ask(:last_name, "What's your last name?")
        @user.add(:full_name, "#{@user.retrieve(:first_name)} #{@user.retrieve(:last_name)}")

        @tokens = Questions.new(:tokens, 'Jarvis-Core use some API. So if you can, provide some tokens.')
        @tokens.ask(:github,
          "Github's API is rate limited at 60 requests / hour.\n" +
          "It's probably not enough for install / update addons from Github.\n" +
          "So you can provide a personnal token to be rate limit to 5000.\n" +
          "Visit https://github.com/settings/tokens/new, untick everything, enter what you want for 'Token Description' and click 'Generate Token'.\n" +
          "Enter your token here:")

        correct_informations?
      end

      def correct_informations?
        if Jarvis::CLI::Stdio.yes?('These informations are correct?')
          save_informations
        else
          puts Rainbow('Be careful, young typer!').color(:red)
          puts Rainbow("Let's try again!").color(:red)
          questions
        end
      end

      def save_informations
        confirm_overwrite if @profile_dev.exists?
        to_save = @user.results['user']
        to_save = to_save.merge(@tokens.results.to_hash)

        folder = @profile_dev.path
        file   = 'user.yml'
        Dir.mkdir(folder, 0755) unless Dir.exist?(folder)
        File.open(File.join(folder, file), 'w') do |f|
          @length = f.write(to_save.to_yaml)
        end

        Jarvis::CLI::Stdio.done("#{file} has been successfully created!") if @length > 1
      end

      def confirm_overwrite
        if Jarvis::CLI::Stdio.no?('An user profile already exists. Are you sure to overwrite it?')
          Jarvis::CLI::Stdio.not_done
          abort
        end
      end
    end
  end
end
