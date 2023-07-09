require_relative "token"

module Monkey
  class Lexer
    attr_accessor :curr_char, :curr_pos, :next_read_pos, :input

    def initialize(input:)
      @curr_char = ""
      @curr_pos = 0
      @input = input
      @next_read_pos = 0

      # NOTE: Might wanna remove it?
      # read_and_advance
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
    # Read the next input, then output corresponding token.
    def next_token
      # NOTE: Contrary to book, read the char before output the token
      read_and_advance

      case curr_char
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
      when 0
        Token.new type: TokenType::EOF, literal: ""
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity

    # Read a char at next_read_pos, and set curr_char with that character
    def read_and_advance
      @curr_char = next_read_pos < input.length ? input[next_read_pos] : 0
      @position = next_read_pos
      @next_read_pos += 1
    end
  end
end
