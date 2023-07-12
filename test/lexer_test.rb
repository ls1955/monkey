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

    def test_tokenise_an_identifier
      input = "tuna"
      lexer = Lexer.new(input:)

      exps = [[TokenType::IDENTIFIER, "tuna"]]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_some_identifiers
      skip
      input = "tuna bonito ham yam"
      lexer = Lexer.new(input:)

      exps = [
        [TokenType::IDENT, "tuna"],
        [TokenType::IDENT, "bonito"],
        [TokenType::IDENT, "ham"],
        [TokenType::IDENT, "yam"]
      ]

      assert_match_tokens exps, lexer
    end

    def test_tokenise_a_valid_monkey_source_code
      skip
      input = <<~INPUT
        let five = 5;
        let ten = 10;

        let add = fn(x, y) {
          x + y;
        };

        let result = add(five, ten);
      INPUT
      lexer = Lexer.new(input:)

      exps = [
        [TokenType::LET, "let"],
        [TokenType::IDENT, "five"],
        [TokenType::ASSIGN, "="],
        [TokenType::INT, 5],
        [TokenType::SEMICOLON, ";"],
        [TokenType::LET, "let"],
        [TokenType::IDENT, "ten"],
        [TokenType::ASSIGN, "="],
        [TokenType::INT, 10],
        [TokenType::SEMICOLON, ";"],
        [TokenType::LET, "let"],
        [TokenType::IDENT, "add"],
        [TokenType::ASSIGN, "="],
        [TokenType::FUNCTION, "fn"],
        [TokenType::LPAREN, "("],
        [TokenType::IDENT, "x"],
        [TokenType::COMMA, ","],
        [TokenType::IDENT, "y"],
        [TokenType::RPAREN, ")"],
        [TokenType::LBRACE, "{"],
        [TokenType::IDENT, "x"],
        [TokenType::PLUS, "+"],
        [TokenType::IDENT, "y"],
        [TokenType::SEMICOLON, ";"],
        [TokenType::RBRACE, "}"],
        [TokenType::SEMICOLON, ";"],
        [TokenType::LET, "let"],
        [TokenType::IDENT, "result"],
        [TokenType::ASSIGN, "="],
        [TokenType::IDENT, "add"],
        [TokenType::LPAREN, "("],
        [TokenType::IDENT, "five"],
        [TokenType::COMMA, ","],
        [TokenType::IDENT, "ten"],
        [TokenType::RPAREN, ")"],
        [TokenType::SEMICOLON, ";"]
      ]

      assert_match_tokens exps, lexer
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
