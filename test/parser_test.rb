require "debug"
require "minitest/autorun"

require_relative "../token"
require_relative "../lexer"
require_relative "../parser"

require_relative "./factory/token_factory"
require_relative "./mock/mock_lexer"

# rubocop:disable Metrics/MethodLength
module Monkey
  class MonkeyParserTest < Minitest::Test
    include TokenType

    def test_read_first_and_second_token_from_lexer_during_initialization
      tokens = TokenFactory.create([
        [IDENTIFIER, "tuna"],
        [ASSIGN, "="],
        [IDENTIFIER, "tuna"]
      ])
      lexer = LexerMock.new(tokens:)
      parser = Parser.new(lexer:)
  
      assert_equal tokens[0], parser.curr_token
      assert_equal tokens[1], parser.peek_token
    end

    def test_parse_program_from_lexer
      input = <<~INPUT
        let num = 1;
        let char = "a";
        let secret_of_universe = 43;
      INPUT

      lexer = Lexer.new(input:)
      parser = Parser.new(lexer:)

      program = parser.parse

      assert program
      assert_equal 3, program.size

      %w(num char secret_of_universe).zip(program.statements).each do |exp_ident, let_statement|
        assert_equal "let", let_statement.token_literal
        assert_equal exp_ident, let_statement.name.val
        assert_equal exp_ident, let_statement.name.token_literal
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
