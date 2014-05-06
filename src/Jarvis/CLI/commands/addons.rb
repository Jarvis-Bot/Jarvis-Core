require 'Jarvis/CLI/stdio'
include Jarvis::CLI::Stdio
module Jarvis
  module CLI
    def self.init(args = nil)
      @args = args
      if @args.nil?
        propose_every_installers
      else
        try_manual_call
      end
    end

    def self.try_manual_call
      installer_path = File.join(__dir__, 'addons_methods', "#{@args.shift}.rb")
      class_name = format_class_name(path_to_class_name(installer_path))
      start_installer(class_name, installer_path)
    rescue LoadError
      Jarvis::Utility::Logger.warning("This installer doesn't exists.")
      propose_every_installers
    end

    def self.propose_every_installers
      Dir[File.join(__dir__, 'addons_methods', '*.rb')].each do |installer_path|
        @choices ||= { for_user: [], for_computer: [] }

        class_name = format_class_name(path_to_class_name(installer_path))
        name = format_class_name(class_name)

        @choices[:for_user].push name
        for_computer = { class_name: class_name, path: installer_path }
        @choices[:for_computer].push for_computer
      end

      to_do = Stdio.pick('What do you want to do?', @choices[:for_user].sort)
      id_to_do = @choices[:for_user].index(to_do)
      installer_infos = @choices[:for_computer][id_to_do]
      start_installer(installer_infos[:class_name], installer_infos[:path])
    end

    def self.path_to_class_name(path)
      file_name = path.split(File::SEPARATOR).last.chomp('.rb')
      if file_name.include?('_')
        file_name = file_name.split('_').each { |part| part.capitalize! }
        file_name.join
      else
        file_name
      end
    end

    def self.format_class_name(class_name)
      format_name = class_name.split(/(?=[A-Z])/)
      "#{format_name.shift.capitalize}"
    end

    def self.start_installer(class_name, path)
      require path
      puts "Starting '#{class_name}'..."
      puts '-----------------------------'
      Object.const_get("Jarvis::CLI::#{class_name}").new
    end
  end
end
