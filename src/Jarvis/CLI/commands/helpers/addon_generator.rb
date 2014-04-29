require 'yaml'
require 'Jarvis/CLI/commands/helpers/questions'
require 'Jarvis/CLI/commands/helpers/profile'
require 'Jarvis/CLI/commands/helpers/files_generator'
require 'Jarvis/CLI/commands/generators/profile_developer'
require 'Jarvis/CLI/stdio'
class AddonGenerator
  def initialize(type)
    @type = type.to_s
  end

  def intro
    puts Rainbow("Welcome in the addon #{@type} generator!").color(:green)
    puts Rainbow("I will ask you some questions about this #{@type} and also about you, if you haven't yet run the developer profile generator.").color(:green)
    puts Rainbow("This #{@type} will be generated under third-party/#{@type}/{YOUR-ADDON}/.").color(:green)
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
  end

  def ask_specs
    specs = Questions.new(:specs, "This is about your #{@type}")
    specs.ask(:name, "What's the name of this #{@type}?")
    specs.ask(:description, "Enter a description of this #{@type}")
    specs.ask(:keywords, 'Enter some keywords about it, separate by a space')
      .modify do |keywords|
        keywords.split ' '
        keywords.downcase
      end
    specs.ask(:homepage, 'Link to the homepage ?', 'a link to your Github repository is a good idea')
    specs.ask(:version, 'Number of your first version ?', '0.1.0 is a good choice')
    specs.ask(:class_name, 'I need to know the name of your class in the init.rb file', "#{specs.retrieve(:name).capitalize}#{@type.capitalize} is a good idea")
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
    specs = @specs.results
    specs = specs.merge(@license.results)
    specs = specs.merge(@repository.results)
    specs = specs.merge(@specific.results)

    @full_specs = [Profile.new(:developer).load, specs] # FIX format (here and templates)
    puts YAML.dump(@full_specs)

    ask_again unless Jarvis::CLI::Stdio.yes?('These informations are correct?')
  end

  def generate_files
    to_generate = ['init.rb']
    to_generate.push 'configure.rb' if Jarvis::CLI::Stdio.yes?('Does the user need to configure your addon before using it?')

    path = "../third-party/#{@type}s/#{@specs.retrieve(:name)}/"
    puts Rainbow("Generating files in '#{path}'").color(:green)

    template_path = File.expand_path(File.join(__dir__, '..', 'generators', 'templates', "addon_#{@type}"))

    to_generate.each do |filename|
      FilesGenerator.new(template_path, filename, path, @full_specs).generate
    end
  end
end
