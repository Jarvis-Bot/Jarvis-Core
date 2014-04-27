require 'Jarvis/CLI/stdio'
include Jarvis::CLI::Stdio
module Jarvis
  module CLI
    def self.init(args = nil)
      @args = args
      if @args.nil?
        propose_every_generators
      else
        try_manual_call
      end
    end

    def self.try_manual_call
      generator_path = File.join(__dir__, 'generators', "#{@args.join('_')}.rb")
      class_name = path_to_class_name(generator_path)
      start_generator(class_name, generator_path)
    rescue LoadError
      Jarvis::Utility::Logger.warning("This generator doesn't exists.")
      propose_every_generators
    end

    def self.propose_every_generators
      Dir[File.join(__dir__, 'generators', '*')].each do |generator_path|
        @choices ||= { for_user: [], for_computer: [] }

        class_name = path_to_class_name(generator_path)
        name = format_class_name(class_name)

        @choices[:for_user].push name
        for_computer = { class_name: class_name, path: generator_path }
        @choices[:for_computer].push for_computer
      end

      to_generate = Stdio.pick('What do you want to generate?', @choices[:for_user])
      id_to_generate = @choices[:for_user].index(to_generate)
      generator_infos = @choices[:for_computer][id_to_generate]
      start_generator(generator_infos[:class_name], generator_infos[:path])
    end

    def self.path_to_class_name(path)
      file_name = path.split(File::SEPARATOR).last.chomp('.rb')
      if file_name.include?('_')
        file_name = file_name.split('_').each { |part| part.capitalize! }
        file_name.join
      else
        fpfile_name
      end
    end

    def self.format_class_name(class_name)
      format_name = class_name.split(/(?=[A-Z])/)
      "[#{format_name.shift.upcase}] #{format_name.join(' ')}"
    end

    def self.start_generator(class_name, path)
      require path
      puts 'Starting generator...'
      puts '-----------------------------'
      Object.const_get(class_name).new
    end
  end
end
