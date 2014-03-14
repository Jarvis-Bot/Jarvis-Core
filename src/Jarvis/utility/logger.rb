module Jarvis
  module Utility
    class Logger
      @@time = Time.now

      # A trick to call this class like "Logger.info" instead of "Logger.new.info"
      class << self
        def add_log_file(log)
          log_file_name = "#{@@time.strftime("%Y-%m-%d %H.%M.%S %z")}.log"
          File.open(File.join("..", "logs", log_file_name), 'a') do |file|
            file.write "#{log}\n"
          end
        end

        %w{debug info warning error fatal}.each do |type_log|
          define_method type_log.to_sym do |*args|
            add_log_file("[#{type_log.upcase}] message")
          end
        end
      end

    end
  end
end
