module Jarvis
  module Utility
    class Logger
      @@time = Time.now

      # A trick to call this class like "Logger.info" instead of "Logger.new.info"
      class << self
        def add_log_file(log)
          log_file_name = "#{@@time.strftime("%Y-%m-%d %H.%M.%S %z")}.log"
          log_folder = File.join('..', 'logs')
          unless Dir.exists?(log_folder)
            Dir.mkdir(log_folder, 0755)
          end
          File.open(File.join(log_folder, log_file_name), 'a') do |file|
            file.write "#{log}\n"
          end
        end

        %w{debug info warning error}.each do |type_log|
          define_method type_log.to_sym do |log|
            add_log_file("[#{type_log.upcase}] #{log}")
            Viewer.send(type_log, log)
          end
        end
      end

    end
  end
end
