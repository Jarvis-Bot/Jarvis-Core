module Jarvis
  class Detector
    def initialize(args)
      @args = args
      case args.first
      when '-h', '--help', 'help'
        help
      when '-c' , '--configure', 'configure'
        config
      else
        something_wrong
      end
    end

    def config
      Config.config_keys
    end

    def help
      Help.display_help
    end

    def something_wrong
      Help.display_something_wrong
    end
  end
end
