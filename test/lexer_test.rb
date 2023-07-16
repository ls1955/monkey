require "debug"
require "minitest/autorun"

require_relative "../lexer"
require_relative "../token"

# rubocop:disable Metrics/MethodLength
module Monkey
  class MonkeyLexerTest < Minitest::Test
    def test_tokenise_some_characters
      input = "=+(){},;"
      lexer = Lexer.new(input:)

      exps = [
        [TokenType::ASSIGN, "="],
        [TokenType::PLUS, "+"],
        [TokenType::LPAREN, "("],
        [TokenType::RPAREN, ")"],
        [TokenType::LBRACE, "{"],
        [TokenType::RBRACE, "}"],
        [TokenType::COMMA, ","],
        [TokenType::SEMICOLON, ";"],
        [TokenType::EOF, ""]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_non_keyword_identifiers
      input = "tuna bonito ham yam"
      lexer = Lexer.new(input:)

      exps = [
        [TokenType::IDENTIFIER, "tuna"],
        [TokenType::IDENTIFIER, "bonito"],
        [TokenType::IDENTIFIER, "ham"],
        [TokenType::IDENTIFIER, "yam"]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_integer_literal_that_token_contain_actual_integer
      input = "1 9 123 8735"
      lexer = Lexer.new(input:)

      exps = [
        [TokenType::INT, 1],
        [TokenType::INT, 9],
        [TokenType::INT, 123],
        [TokenType::INT, 8735]
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
        [TokenType::LET, "let"],
        [TokenType::IDENTIFIER, "add"],
        [TokenType::ASSIGN, "="],
        [TokenType::FUNCTION, "fn"],
        [TokenType::LPAREN, "("],
        [TokenType::IDENTIFIER, "x"],
        [TokenType::COMMA, ","],
        [TokenType::IDENTIFIER, "y"],
        [TokenType::RPAREN, ")"],
        [TokenType::LBRACE, "{"],
        [TokenType::IDENTIFIER, "x"],
        [TokenType::PLUS, "+"],
        [TokenType::IDENTIFIER, "y"],
        [TokenType::SEMICOLON, ";"],
        [TokenType::RBRACE, "}"],
        [TokenType::SEMICOLON, ";"],
        [TokenType::LET, "let"],
        [TokenType::IDENTIFIER, "result"],
        [TokenType::ASSIGN, "="],
        [TokenType::IDENTIFIER, "add"],
        [TokenType::LPAREN, "("],
        [TokenType::IDENTIFIER, "five"],
        [TokenType::COMMA, ","],
        [TokenType::IDENTIFIER, "ten"],
        [TokenType::RPAREN, ")"],
        [TokenType::SEMICOLON, ";"]
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
        [TokenType::BANG, "!"],
        [TokenType::MINUS, "-"],
        [TokenType::SLASH, "/"],
        [TokenType::ASTERISK, "*"],
        [TokenType::SEMICOLON, ";"],
        [TokenType::INT, 5],
        [TokenType::LT, "<"],
        [TokenType::INT, 10],
        [TokenType::GT, ">"],
        [TokenType::INT, 5]
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
        [TokenType::IF, "if"],
        [TokenType::LPAREN, "("],
        [TokenType::IDENTIFIER, "num"],
        [TokenType::LT, "<"],
        [TokenType::INT, 10],
        [TokenType::RPAREN, ")"],
        [TokenType::LBRACE, "{"],
        [TokenType::RETURN, "return"],
        [TokenType::TRUE, "true"],
        [TokenType::RBRACE, "}"],
        [TokenType::ELSE, "else"],
        [TokenType::LBRACE, "{"],
        [TokenType::RETURN, "return"],
        [TokenType::FALSE, "false"],
        [TokenType::RBRACE, "}"]
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
