# frozen_string_literal: true

module Monkey
  Token = Struct.new :type, :literal, keyword_init: true

  module TokenType
    # An unknown token/character
    ILLEGAL = "ILLEGAL"
    EOF = "EOF"

    # Identifiers + literals
    IDENTIFIER = "IDENTIFIER"
    INT = "INT"

    # Operators
    ASSIGN = "="
    PLUS = "+"

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
  end

  KEYWORDS = {
    "let" => TokenType::LET,
    "fn" => TokenType::FUNCTION
  }
end
