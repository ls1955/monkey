require "debug"
require "minitest/autorun"

require_relative "../token"

require_relative "./factory/token_factory"

module Monkey
  class TokenFactoryTest < Minitest::Test
    include TokenType

    def test_factory_return_correct_token
      token_arguments = [
        [IDENTIFIER, "kuma"],
        [INT, 1],
        [FUNCTION, "fn"],
        [RPAREN, ")"]
      ]
      tokens = token_arguments.map { |type, literal| Token.new(type:, literal:)  }

      assert_equal tokens, TokenFactory.create(token_arguments)
    end
  end
end