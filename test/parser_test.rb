require "debug"
require "minitest/autorun"

require_relative "../token"
require_relative "../lexer"
require_relative "../parser"

require_relative "./factory/token_factory"
require_relative "./mock/mock_lexer"

# rubocop:disable Metrics/MethodLength
module Monkey
  class MonkeyParserTest < Minitest::Test
    include TokenType

    def test_read_first_and_second_token_from_lexer_during_initialization
      tokens = TokenFactory.create([
        [IDENTIFIER, "tuna"],
        [ASSIGN, "="],
        [IDENTIFIER, "tuna"]
      ])
      lexer = LexerMock.new(tokens:)
      parser = Parser.new(lexer:)
  
      assert_equal tokens[0], parser.curr_token
      assert_equal tokens[1], parser.peek_token
    end
  end
end
# rubocop:enable Metrics/MethodLength
