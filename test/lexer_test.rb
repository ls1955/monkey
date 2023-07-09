require "debug"
require "minitest/autorun"

require_relative "../lexer"
require_relative "../token"

# rubocop:disable Metrics/MethodLength
module Monkey
  class MonkeyLexerTest < Minitest::Test
    def test_lexer_tokenise_input_one
      input = "=+(){},;"
      lexer = Lexer.new input: input

      exps = [
        [TokenType::ASSIGN, "="],
        [TokenType::PLUS, "+"],
        [TokenType::LPAREN, "("],
        [TokenType::RPAREN, ")"],
        [TokenType::LBRACE, "{"],
        [TokenType::RBRACE, "}"],
        [TokenType::COMMA, ","],
        [TokenType::SEMICOLON, ";"],
        [TokenType::EOF, ""]
      ]

      (input.length + 1).times do |i|
        token = lexer.next_token

        assert_equal exps[i][0], token.type
        assert_equal exps[i][1], token.literal
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
