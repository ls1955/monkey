# frozen_string_literal: true

# As filename suggest, this file contain token and some keywords
# use inside the Monkey programming language.

# Go code from books
# As Author is unfamilliar with Go,
# will leave them at there for future reference
# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# type TokenType string

# type Token struct {
#   Type TokenType
#   Literal string
# }
# 
# const (
#   ILLEGAL = "ILLEGAL"
#   ...
# )
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

module Monkey
  Token = Struct.new :type, :literal, keyword_init: true

  module Token
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
end
