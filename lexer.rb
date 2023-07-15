require_relative "token"

class String
  def whitespace?
    # References: https://ruby-doc.org/3.2.2/String.html#class-String-label-Whitespace+in+Strings
    ["\x00", "\x09", "\x0a", "\x0b", "\x0c", "\x0d", "\x20"].include? self
  end
end

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
      skip_whitespaces

      result =
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
        when "\x00"
          Token.new type: TokenType::EOF, literal: ""
        else
          if valid_integer_letter? curr_char
            integer = next_integer
            type = TokenType::INT
            return Token.new type:, literal: integer
          elsif valid_identifier_letter? curr_char
            identifier = next_identifier
            type = token_type_for identifier
            return Token.new type:, literal: identifier
          else
            Token.new type: TokenType::ILLEGAL, literal: curr_char
          end
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

    # Keep reading valid integer literals and return it as an integer
    def next_integer
      start_pos = curr_pos
      read_and_advance while valid_integer_letter?(curr_char)
      input[start_pos...curr_pos].to_i
    end

    private

    def skip_whitespaces
      # An early return to prevent infinite loop after reading past the input
      # FIXME: Might be a bug, as reference doesn't need this condition
      return unless curr_pos < input.length

      read_and_advance while curr_char.whitespace?
    end

    def token_type_for(literal)
      return KEYWORDS[literal] if KEYWORDS.include? literal

      TokenType::IDENTIFIER
    end

    def valid_integer_letter?(char)
      char.match?(/\d/)
    end

    def valid_identifier_letter?(char)
      char.match?(/[a-zA-Z_]/)
    end
  end
end
