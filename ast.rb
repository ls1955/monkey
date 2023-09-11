module Monkey
  class AST
    attr_accessor :statements

    def initialize
      @statements = []
    end

    def token_literal
      return "" if statements.empty?

      statements.first.token_literal
    end

    LetStatement = Struct.new "LetStatement", :token, :value, :expression, keyword_init: true do
      def token_literal
        token.literal
      end
    end

    Identifier = Struct.new "Identifier", :token, :value, keyword_init: true do
      def token_literal
        token.literal
      end
    end
  end
end
