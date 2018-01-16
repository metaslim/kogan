require_relative 'base'

module Kogan
  module Commands
    class Quit < Kogan::Commands::Base
      private

      def is_valid?(input)
        input =~ /^quit$/
      end

      def execute(client, input)
        exit(0)
      end
    end
  end
end
