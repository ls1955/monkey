module Monkey
  # The almighty lexer for Monkey programming language
  class Parser
    attr_reader :curr_token, :lexer, :peek_token

    def initialize(lexer:)
      @lexer = lexer

      # BECAUSE:
      # To setup both curr_token and peek_token before anything else
      2.times { next_token }
    end

    # Read through the tokens from lexer and update current and next token
    # that the parser is working with
    def next_token
      @curr_token = peek_token
      @peek_token = lexer.next_token
    end
  end
end
