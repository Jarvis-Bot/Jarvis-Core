require 'rainbow'
module Jarvis
  module CLI
    class Questions
      def initialize(theme, announce = nil)
        print "\n"
        puts Rainbow(announce).color(:yellow) unless announce.nil?
        @answers = {}
        @theme = theme.to_s
      end

      def ask(var_name, question, hint = nil)
        @last_entry = var_name.to_s
        print Rainbow("#{question} ").color(:magenta)
        print Rainbow("(#{hint})").color(:cyan) unless hint.nil?
        print Rainbow(': ').color(:magenta)
        @answers[var_name.to_s] = $stdin.gets.chomp.strip
        self
      end

      def add(var_name, answer)
        @last_entry = var_name.to_s
        @answers[var_name.to_s] = answer
        self
      end

      def modify(var_name = nil, &block)
        if var_name.nil?
          answer = @answers[@last_entry]
          answer = yield answer
          @answers[@last_entry] = answer
        else
          answer = yield @answers[var_name.to_s]
          @answers[var_name.to_s] = answer
        end
        self
      end

      def retrieve(var_name)
        @answers[var_name.to_s]
      end

      def results
        { @theme => @answers }
      end
    end
  end
end
