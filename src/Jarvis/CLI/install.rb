module Jarvis
  module CLI
    def self.init(args)
      @specs_file = YAML::load open('https://raw.githubusercontent.com/Jarvis-Bot/HelloWorld-plugin/master/plugin.yml').read
      self.ask_confirm
    end

    def self.ask_confirm
      puts "Are you sure to install \"#{Rainbow(@specs_file["Plugin"]["name"]).green}\" created by \"#{Rainbow(@specs_file["Author"]["name"]).green}\"? [Y/n]"
      confirm = $stdin.gets.chomp
      yes_cases = ["yes", "YES", "y", "Y", ""]
      if yes_cases.include? confirm
        puts "youpi"
      end
    end
  end
end