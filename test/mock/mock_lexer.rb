require "debug"

require_relative "../../token"

module Monkey
  # To ensure other tests that require lexer to work
  # continue to work as intended, even if actual lexer
  # is not.
  class LexerMock
    attr_reader :current_index, :tokens

    def initialize(tokens:)
      @current_index = 0
      @tokens = tokens
    end

    def current_token
      tokens[current_index]
    end

    def next_token
      return Token.new(type: TokenType::EOF, literal: "") unless current_index < tokens.length

      result = tokens[current_index]
      @current_index += 1
      result
    end
  end
end
