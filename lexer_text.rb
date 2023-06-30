require "debug"
require "minitest/autorun"

require_relative "lexer"
require_relative "token"

module Monkey
  class LexerTest < Minitest::Test
    def test_lexer_case1
      str = "=+(){},;"
      lexer = Lexer.new str

      exp = [
        [Token.ASSIGN, "="],
        [Token.PLUS, "+"],
        [Token.LPAREN, "("],
        [Token.RPAREN, ")"],
        [Token.LBRACE, "{"],
        [Token.RBRACE, "}"],
        [Token.COMMA, ","],
        [Token.SEMICOLON, ";"]
      ]

      src_code.each_char.with_index do |chr, i|
        tkn = lexer.next_tkn

        assert_equal exp[i][0], tkn
        assert_equal exp[i][1], tkn.literal
      end
    end
  end
end
