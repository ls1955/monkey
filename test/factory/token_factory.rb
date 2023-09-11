require "debug"

require_relative "../../token"

module Monkey
  class TokenFactory
    class << self
      # Take arguments for token and return respective tokens
      def create(token_arguments)
        token_arguments.map { |type, literal| Token.new(type:, literal:) }
      end
    end
  end
end
