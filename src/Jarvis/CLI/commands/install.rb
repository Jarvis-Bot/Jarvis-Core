require 'Jarvis/CLI/stdio'
require 'json'
include Jarvis::CLI::Stdio
module Jarvis
  module CLI
    def self.init(raw_link)
      self.splitter(raw_link)
      @specs_file = self.get_specs_file
      self.ask_install_confirm
    end

    def self.splitter(raw_link)
      splitted = raw_link.pop.split('/')
      repo_and_user = splitted.pop(2)
      @user = repo_and_user[0]
      @repo = repo_and_user[1]

      if @repo.end_with? '.git' # http://github.com/User/Repository.git
        @repo.chomp!('.git')
        if @user.include? 'git@github.com' # git@github.com:User/Repository
          @user.sub!(/git@github.com:/, '')
        end
      end
    end

    def self.get_specs_file
      @specs_url = "https://raw.githubusercontent.com/#{@user}/#{@repo}/master/plugin.yml"
      begin
        YAML::load open(@specs_url).read
      rescue OpenURI::HTTPError => e
        Utility::Logger.error("#{e.io.status.shift} #{e.io.status.shift} : '#{@specs_url}' wasn't found", :block => false)
      end
    end

    def self.ask_install_confirm
      print "Are you sure to install \"#{Rainbow(@specs_file["Plugin"]["name"]).green}\" created by \"#{Rainbow(@specs_file["Author"]["name"]).green}\"? [Y/n]"
      if Stdio.yes?($stdin.gets.chomp.strip)
        self.ask_version_to_install
      end
    end

    def self.ask_version_to_install
      tags_list = JSON::load open("https://api.github.com/repos/#{@user}/#{@repo}/tags").read

      if tags_list.empty?
        Utility::Logger.error("'#{@repo}' doesn't have any tags.", :block => false)
      end

      releases = []
      tags_list.shift(10).each do |release|
        releases.push release["name"]
      end

      version_to_install = Stdio.pick("Which version would you like to install?", releases)
      self.install(version_to_install)
    end

    def self.install(version)
      github_link = "https://github.com/#{@user}/#{@repo}/"
      install_path = File.join('..', 'third-party', "#{@user}_#{@repo}")
      pp install_path
      self.git %|clone -n --branch #{version} #{github_link} #{install_path}|
    end

  private

    def self.git(command)
      out = %x{git #{command}}
      Stdio.done("\"#{@repo}\" has been successfully installed!") if $?.success?
    end
  end
end