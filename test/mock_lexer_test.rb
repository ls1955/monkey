require "debug"
require "minitest/autorun"

require_relative "./mock/mock_lexer"
require_relative "../token"

module Monkey
  class MockLexerTest < Minitest::Test
    include TokenType

    def test_it_return_correct_next_token
      token_one = Token.new type: IDENTIFIER, literal: "kuma"
      token_two = Token.new type: INT, literal: 42
      token_three = Token.new type: FUNCTION, literal: "fn"
      token_four = Token.new type: IDENTIFIER, literal: "print_crap"
      tokens = [token_one, token_two, token_three, token_four]

      mock = LexerMock.new(tokens:)

      tokens.each { assert_equal _1, mock.next_token }
    end
  end
end