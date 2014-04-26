require 'json'
require 'yaml'
require 'open-uri'
require 'rainbow'
require 'Jarvis/CLI/stdio'
include Jarvis::CLI::Stdio
LONG_HELP = <<-EOS
Usage: ./jarvis install [URL]
  URL can be something like:

  /User/Repository/
  /User/Repository
  User/Repository/

  github.com/User/Repository

  http[s]://github.com/User/Repository
  http[s]://github.com/User/Repository.git

  git@github.com:User/Repository.git


The repository MUST contains a valid specs.yml file!
EOS
module Jarvis
  module CLI
    def self.long_help
      puts LONG_HELP
    end

    def self.init(raw_link)
      splitter(raw_link)
      @specs = find_specs_file
      ask_install_confirm
    end

    def self.splitter(raw_link)
      splitted = raw_link.pop.split('/')
      repo_and_user = splitted.pop(2)
      @user = repo_and_user[0].downcase
      @repo = repo_and_user[1].downcase

      if @repo.end_with? '.git' # http://github.com/User/Repository.git
        @repo.chomp!('.git')
        @user.sub!(/git@github.com:/, '') if @user.include? 'git@github.com' # git@github.com:User/Repository
      end
    end

    def self.find_specs_file
      @specs_url = "https://raw.githubusercontent.com/#{@user}/#{@repo}/master/specs.yml"
      begin
        YAML.load open(@specs_url).read
      rescue OpenURI::HTTPError => e
        Utility::Logger.error("#{e.io.status.shift} #{e.io.status.shift} : '#{@specs_url}' wasn't found")
      end
    end

    def self.ask_install_confirm
      thirdparty_name = Rainbow(@specs['specs']['name']).green
      author_name = Rainbow(@specs['author']['name']).green
      type = Rainbow(@specs['specs']['type']).magenta

      print "Are you sure to install this #{type}: \"#{thirdparty_name}\" created by \"#{author_name}\"? [Y/n]"
      ask_version_to_install if Stdio.yes?($stdin.gets.chomp.strip)
    end

    def self.ask_version_to_install
      tags_list = JSON.load open("https://api.github.com/repos/#{@user}/#{@repo}/tags").read

      if tags_list.empty?
        Utility::Logger.error("'#{@repo}' doesn't have any tags. \nSee https://help.github.com/articles/creating-releases for more information.")
      end

      releases = []
      tags_list.shift(10).each do |release|
        releases.push release['name']
      end

      version_to_install = Stdio.pick('Which version would you like to install?', releases)
      install(version_to_install)
    end

    def self.install(version)
      github_link = "https://github.com/#{@user}/#{@repo}/"
      install_path = File.join('..', 'third-party', "#{@specs['specs']['type']}s", "#{@user}_#{@repo}")
      git %(clone --branch #{version} #{github_link} #{install_path})
    end

    private

    def self.git(command)
      %x(git #{command})
      Stdio.done("\"#{@repo}\" has been successfully installed!") if $?.success?
    end
  end
end
