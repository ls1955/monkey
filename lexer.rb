require_relative "token"

module Monkey
  class Lexer
    attr_accessor :curr_char, :curr_pos, :next_read_pos, :input

    def initialize(input:)
      @curr_char = ""
      @curr_pos = 0
      @input = input
      @next_read_pos = 0

      read_and_advance
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
    # Read the next input, then output corresponding token.
    def next_token
      result = case curr_char
        when "="
          Token.new type: TokenType::ASSIGN, literal: curr_char
        when "+"
          Token.new type: TokenType::PLUS, literal: curr_char
        when "("
          Token.new type: TokenType::LPAREN, literal: curr_char
        when ")"
          Token.new type: TokenType::RPAREN, literal: curr_char
        when "{"
          Token.new type: TokenType::LBRACE, literal: curr_char
        when "}"
          Token.new type: TokenType::RBRACE, literal: curr_char
        when ","
          Token.new type: TokenType::COMMA, literal: curr_char
        when ";"
          Token.new type: TokenType::SEMICOLON, literal: curr_char
        when "\x00"
          Token.new type: TokenType::EOF, literal: ""
        else
          identifier = next_identifier
          type = token_type_for identifier
          Token.new type:, literal: identifier
        end

      read_and_advance

      result
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity

    # Read a char at next_read_pos, and set curr_char with that character
    def read_and_advance
      @curr_char = next_read_pos < input.length ? input[next_read_pos] : "\x00"
      @curr_pos = next_read_pos
      @next_read_pos += 1
    end

    # Keep reading the valid characters and return it as a substring
    def next_identifier
      start_pos = curr_pos
      read_and_advance while valid_identifier_letter?(curr_char)
      input[start_pos...curr_pos]
    end

    private

    def token_type_for(literal)
      return KEYWORDS[literal] if KEYWORDS.include? literal

      TokenType::IDENTIFIER
    end

    def valid_identifier_letter?(char)
      char.match?(/[a-zA-Z0-9_]/)
    end
  end
end
