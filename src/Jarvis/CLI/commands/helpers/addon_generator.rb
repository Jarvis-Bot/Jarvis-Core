require 'yaml'
require 'Jarvis/CLI/commands/helpers/questions'
require 'Jarvis/CLI/commands/helpers/profile'
require 'Jarvis/CLI/commands/helpers/files_generator'
require 'Jarvis/CLI/commands/generators/profile_developer'
require 'Jarvis/CLI/stdio'
module Jarvis
  module CLI
    class AddonGenerator
      def initialize(type)
        @type = type.to_s
      end

      def intro
        puts Rainbow("Welcome in the addon #{@type} generator!").color(:green)
        puts Rainbow("I will ask you some questions about this #{@type} and also about you, if you haven't yet run the developer profile generator.").color(:green)
        puts Rainbow("This #{@type} will be generated under addons/#{@type}/{YOUR-ADDON}/.").color(:green)
        print "\n"

        dev_profile_exists?
      end

      def dev_profile_exists?
        unless Profile.new(:developer).exists?
          puts Rainbow("Oops, you don't have a profile yet! It's useful to generate an addon.").color(:yellow)
          puts Rainbow("Don't worry, I will guide you to create one.").color(:yellow)
          sleep 2
          puts '-----------------------------'
          ProfileDeveloper.new
        end
      end

      def default_specs
        ask_specs
        ask_license
        ask_repository
        ask_dependencies
      end

      def ask_specs
        specs = Questions.new(:specs, "This is about your #{@type}")
        specs.ask(:name, "What's the name of this #{@type}?")
        specs.ask(:description, "Enter a description of this #{@type}")
        specs.ask(:keywords, 'Enter some keywords about it, separate by a space')
          .modify do |keywords|
            keywords.downcase
            keywords.split ' '
          end
        specs.ask(:homepage, 'Link to the homepage ?', 'a link to your Github repository is a good idea')
        specs.ask(:version, 'Number of your first version ?', '0.1.0 is a good choice')
        specs.ask(:class_name, 'I need to know the name of your class in the init.rb file', "#{specs.retrieve(:name).capitalize}#{@type.capitalize} is a good idea")
          .modify do |class_name|
            class_name[0].capitalize + class_name[1..-1]
          end
        specs.add(:type, @type)
        @specs = specs
      end

      def ask_license
        license = Questions.new(:license, "About the license of your #{@type}")
        license.ask(:type, 'Enter your license.', 'We use MIT for Jarvis')
        license.ask(:url, 'Enter the link to your license file')
        @license = license
      end

      def ask_repository
        repository = Questions.new(:repository, 'This is about your repository settings')
        repository.ask(:type, 'Enter the type of your repository', 'git, SVN...')
        repository.ask(:url, 'Enter the url of your repository')
        @repository = repository
      end

      def ask_dependencies
        dependencies = Questions.new(:dependencies, 'Does this addon have some dependencies?')
        dependencies.ask(:jarvis, 'Enter the version as major.minor.patch[.pre]', "If this field is empty, it will required the current major version, v#{JARVIS[:version_splitted][:major]}.#{JARVIS[:version_splitted][:minor]}")
        .modify do |jarvis|
          jarvis = "~> #{JARVIS[:version_splitted][:major]}.#{JARVIS[:version_splitted][:minor]}"
        end
        @dependencies = dependencies
      end

      def ask_specific(&block)
        @specific_block ||= block
        @specific = @specific_block.call
        summary
      end

      def ask_again
        picked = Jarvis::CLI::Stdio.pick('Where did you make a mistake?', ['Specs', 'License', 'Repository', "Specific #{@type}"])
        picked.slice!(@type)
        send("ask_#{picked.downcase.strip}")
        summary
      end

      def summary
        specs = {}
        @specs.results['specs'].each { |key, value| specs.store(key, value) }
        specs = specs.merge({
          'license' => @license.results['license'],
          'repository' => @repository.results['repository'],
          'dependencies' => @dependencies.results['dependencies']
        })
        author = Profile.new(:developer).load
        @full_specs =  { 'author' => author.to_h }.merge({ 'specs' => specs }).merge({@specific.results.keys[0] => @specific.results.values[0]})
        puts YAML.dump(@full_specs)
        ask_again unless Jarvis::CLI::Stdio.yes?('These informations are correct?')
      end

      def generate_files
        @path = "../addons/#{@type}s/#{@specs.retrieve(:name)}/"
        generate_from_templates
        generate_from_specs
      end

      def generate_from_templates
        to_generate = ['init.rb']
        to_generate.push 'configure.rb' if Jarvis::CLI::Stdio.yes?('Does the user need to configure your addon before using it?')
        template_path = File.expand_path(File.join(__dir__, '..', 'generators', 'templates', "addon_#{@type}"))
        puts Rainbow("Generating files in '#{@path}'").color(:green)
        to_generate.each do |filename|
          FilesGenerator.new(template_path, filename, @path, @full_specs).generate
        end
      end

      def generate_from_specs
        File.open(File.join(@path, 'specs.yml'), 'w') do |f|
          f.write(@full_specs.to_yaml)
        end
      end
    end
  end
end
