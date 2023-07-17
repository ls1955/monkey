require "debug"
require "minitest/autorun"

require_relative "../lexer"
require_relative "../token"

# rubocop:disable Metrics/MethodLength
module Monkey
  class MonkeyLexerTest < Minitest::Test
    include TokenType

    def test_tokenise_some_characters
      input = "=+(){},;"
      lexer = Lexer.new(input:)

      exps = [
        [ASSIGN, "="],
        [PLUS, "+"],
        [LPAREN, "("],
        [RPAREN, ")"],
        [LBRACE, "{"],
        [RBRACE, "}"],
        [COMMA, ","],
        [SEMICOLON, ";"],
        [EOF, ""]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_non_keyword_identifiers
      input = "tuna bonito ham yam"
      lexer = Lexer.new(input:)

      exps = [
        [IDENTIFIER, "tuna"],
        [IDENTIFIER, "bonito"],
        [IDENTIFIER, "ham"],
        [IDENTIFIER, "yam"]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_integer_literal_that_token_contain_actual_integer
      input = "1 9 123 8735"
      lexer = Lexer.new(input:)

      exps = [
        [INT, 1],
        [INT, 9],
        [INT, 123],
        [INT, 8735]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_a_function_declaration_and_expression
      input = <<~INPUT
        let add = fn(x, y) {
          x + y;
        };

        let result = add(five, ten);
      INPUT
      lexer = Lexer.new(input:)

      exps = [
        [LET, "let"],
        [IDENTIFIER, "add"],
        [ASSIGN, "="],
        [FUNCTION, "fn"],
        [LPAREN, "("],
        [IDENTIFIER, "x"],
        [COMMA, ","],
        [IDENTIFIER, "y"],
        [RPAREN, ")"],
        [LBRACE, "{"],
        [IDENTIFIER, "x"],
        [PLUS, "+"],
        [IDENTIFIER, "y"],
        [SEMICOLON, ";"],
        [RBRACE, "}"],
        [SEMICOLON, ";"],
        [LET, "let"],
        [IDENTIFIER, "result"],
        [ASSIGN, "="],
        [IDENTIFIER, "add"],
        [LPAREN, "("],
        [IDENTIFIER, "five"],
        [COMMA, ","],
        [IDENTIFIER, "ten"],
        [RPAREN, ")"],
        [SEMICOLON, ";"]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_single_character_operator
      input = <<~INPUT
        !-/*;
        5 < 10 > 5
      INPUT
      lexer = Lexer.new(input:)

      exps = [
        [BANG, "!"],
        [MINUS, "-"],
        [SLASH, "/"],
        [ASTERISK, "*"],
        [SEMICOLON, ";"],
        [INT, 5],
        [LT, "<"],
        [INT, 10],
        [GT, ">"],
        [INT, 5]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_two_characters_operators
      input = <<~INPUT
        potato == vegetable
        tuna != bonito
      INPUT
      lexer = Lexer.new(input:)

      exps = [
        [IDENTIFIER, "potato"],
        [EQ, "=="],
        [IDENTIFIER, "vegetable"],
        [IDENTIFIER, "tuna"],
        [NOT_EQ, "!="],
        [IDENTIFIER, "bonito"]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_keywords_identifiers
      input = <<~INPUT
        if (num < 10) {
          return true
        } else {
          return false
        }
      INPUT
      lexer = Lexer.new(input:)

      exps = [
        [IF, "if"],
        [LPAREN, "("],
        [IDENTIFIER, "num"],
        [LT, "<"],
        [INT, 10],
        [RPAREN, ")"],
        [LBRACE, "{"],
        [RETURN, "return"],
        [TRUE, "true"],
        [RBRACE, "}"],
        [ELSE, "else"],
        [LBRACE, "{"],
        [RETURN, "return"],
        [FALSE, "false"],
        [RBRACE, "}"]
      ]
    end

    private

    # :exps: An nested array of type and literal
    # :lexer: A lexer that already loaded with input
    def assert_match_tokens(exps, lexer)
      exps.each do |type, literal|
        token = lexer.next_token

        assert_equal type, token.type
        assert_equal literal, token.literal
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
