require "debug"
require "minitest/autorun"

require_relative "../lexer"
require_relative "../token"

# rubocop:disable Metrics/MethodLength
module Monkey
  class MonkeyLexerTest < Minitest::Test
    def test_lexer_tokenise_input_one
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

      (input.length + 1).times do |i|
        token = lexer.next_token

        assert_equal exps[i][0], token.type
        assert_equal exps[i][1], token.literal
      end
    end

    def test_lexer_tokenise_input_two
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

      index = 0
      until lexer.char.type == TokenType::EOF
        token = lexer.next_token

        assert_equal exps[index][0], token.type
        assert_equal exps[index][1], token.literal

        index += 1
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
