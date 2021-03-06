module Jarvis
  module Utility
    class Logger
      @@time = Time.now

      # A trick to call this class like "Logger.info" instead of "Logger.new.info"
      class << self
        def add_log_file(log)
          log_file_name = "#{@@time.strftime('%Y-%m-%d %H.%M.%S')}.log"
          log_folder = File.join(JARVIS[:root], 'logs')
          Dir.mkdir(log_folder, 0755) unless Dir.exist?(log_folder)
          File.open(File.join(log_folder, log_file_name), 'a') do |file|
            file.write "#{log}\n"
          end
        end

        %w(debug message info warning error).each do |type_log|
          define_method type_log.to_sym do |log, options = { log: true, view: true, color: nil }|
            add_log_file("#{Time.new.strftime('%d/%m/%Y %H.%M.%S')} [#{type_log.upcase}] #{log}") if options[:log]
            Viewer::Log.log_factory(type_log, log, options)
          end
        end
      end
    end
  end
end
