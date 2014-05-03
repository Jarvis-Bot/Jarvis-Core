# Based on https://github.com/ninefold/cli/blob/master/lib/ninefold/services/stdio.rb by Ninefold
#   Released under MIT License.
#   Copyright (c) 2013 Yehuda Katz, Ninefold
require 'rainbow'
module Jarvis
  module CLI
    module Stdio
      def pick(title, options)
        print Rainbow("#{title}").magenta
        print Rainbow(' (Use arrows and press Enter)').yellow

        puts "\n" * (options.size + 2)

        selected = 0

        print_options(options, selected)

        loop do
          case read_key
          when "\e[A" # UP
            selected -= 1
            selected = options.size - 1 if selected < 0
            print_options(options, selected)

          when "\e[B" # DOWN
            selected += 1
            selected = 0 if selected > options.size - 1
            print_options(options, selected)

          when "\r", "\n" # ENTER
            return options[selected]

          when "\u0003", "\e" # Ctrl+C, ESC
            puts "\n"
            exit(0)
          end
        end
      end

      def print_options(options, selected = 0)
        print "\r\e[#{options.size + 1}A"

        options.each_with_index do |option, i|
          print Rainbow(" #{i == selected ? '→' : ' '}").cyan
          print Rainbow(" #{i == selected ? "\e[0m  " + Rainbow("#{option}\n").underline : "\e[0m  #{option}\n"}")
        end

        print "\n"
      end

      def read_key
        old_state = `stty -g`
        `stty raw -echo`

        c = STDIN.getc.chr

        if c == "\e" # reading escape sequences
          extra_thread = Thread.new do
            c += STDIN.getc.chr + STDIN.getc.chr
          end
          extra_thread.join(0.001)
          extra_thread.kill
        end

        c

      ensure
        `stty #{old_state}`
      end

      def yes?(question, options = {color: true})
        print options[:color] ? Rainbow("#{question} [Y/n]").color(:green) : "#{question} [Y/n]"
        answer = $stdin.gets.chomp.strip
        yes_cases = ['yes', 'YES', 'y', 'Y', '']
        yes_cases.include? answer
      end

      def no?(question, options = {color: true})
        print options[:color] ? Rainbow("#{question} [N/y]").color(:red) : "#{question} [N/y]"
        answer = $stdin.gets.chomp.strip
        no_cases = ['no', 'NO', 'n', 'N', '']
        no_cases.include? answer
      end

      def done(text = 'Done.')
        puts Rainbow("✔  #{text}").green
      end

      def not_done(text = 'Not done.')
        puts Rainbow("✘  #{text}").red
      end
    end
  end
end
