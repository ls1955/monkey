# frozen_string_literal: false

require_relative "lexer"

# :nodoc:
module Monkey
  # IMK stands for "Interactive MonKey", it is the REPL for Monkey
  class IMK
    # The main loop which for now print every tokens for user inputs
    def execute
      print_intro

      print ">> "
      input = gets.strip

      until input == ""
        lexer = Lexer.new(input:)

        puts ""
        lexer.each_token { puts _1 }
        puts ""

        print ">> "
        input = gets.strip
      end
    end

    def print_intro
      puts <<~INTRO
        ------------------------------------------------------------
          Type any expression to see the tokens that lexer produce.
          Press Ctrl + D or enter nothing to exit.
        ------------------------------------------------------------
      INTRO
    end
  end
end

Monkey::IMK.new.execute
