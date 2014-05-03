require 'rainbow'
require 'yaml'
require 'Jarvis/CLI/commands/helpers/questions'
require 'Jarvis/CLI/commands/helpers/profile'
require 'Jarvis/CLI/stdio'
module Jarvis
  module CLI
    class ProfileDeveloper
      def initialize
        @profile_dev = Jarvis::CLI::Profile.new(:developer)
        intro
        questions
      end

      def intro
        puts Rainbow('Welcome in the generator of developer profile!').color(:green)
        puts Rainbow('This profile will be used by the addon generator').color(:green)
        puts Rainbow('Your data will be stored in config/profiles/developer.yml').color(:green)
        print "\n"
      end

      def questions
        @author = Questions.new(:author, 'This is about you, the author.')
        @author.ask(:name, "What's your full name?")

        @contacts = Questions.new(:contacts, 'Now, I need to know how people can contact you.')
        @contacts.ask(:email, 'Your email plz')
        @contacts.ask(:github, 'Your Github account name plz')
        @contacts.ask(:twitter, 'Your pseudo on twitter ? (without the @)')

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
        to_save = @author.results['author']
        to_save = to_save.merge(@contacts.results.to_hash)

        folder = File.expand_path(File.join('..', 'config', 'profiles'))
        file   = 'developer.yml'
        Dir.mkdir(folder, 0755) unless Dir.exist?(folder)
        File.open(File.join(folder, file), 'w') do |f|
          @length = f.write(to_save.to_yaml)
        end

        Jarvis::CLI::Stdio.done("#{file} has been successfully created!") if @length > 1
      end

      def confirm_overwrite
        if Jarvis::CLI::Stdio.no?('A developer profile already exists. Are you sure to overwrite it?')
          Jarvis::CLI::Stdio.not_done
          abort
        end
      end
    end
  end
end