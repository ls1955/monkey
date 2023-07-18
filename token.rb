# frozen_string_literal: true

module Monkey
  Token = Struct.new :type, :literal, keyword_init: true do
    def to_s
      "type: #{type}, literal: #{literal}"
    end
  end

  module TokenType
    # An unknown token/character
    ILLEGAL = "ILLEGAL"
    EOF = "EOF"

    # Identifiers + literals
    IDENTIFIER = "IDENTIFIER"
    INT = "INT"

    # Operators
    ASSIGN = "="
    BANG = "!"
    PLUS = "+"
    MINUS = "-"
    ASTERISK = "*"
    SLASH = "/"

    LT = "<"
    GT = ">"
    EQ = "=="
    NOT_EQ = "!="

    # Delimiters
    COMMA = ","
    SEMICOLON = ";"

    LPAREN = "("
    RPAREN = ")"
    LBRACE = "{"
    RBRACE = "}"

    # Keywords
    FUNCTION = "FUNCTION"
    LET = "LET"
    RETURN = "RETURN"

    IF = "IF"
    ELSE = "ELSE"

    TRUE = "TRUE"
    FALSE = "FALSE"
  end

  KEYWORDS = {
    "fn" => TokenType::FUNCTION,
    "let" => TokenType::LET,
    "return" => TokenType::RETURN,
    "if" => TokenType::IF,
    "else" => TokenType::ELSE,
    "true" => TokenType::TRUE,
    "false" => TokenType::FALSE
  }
end
