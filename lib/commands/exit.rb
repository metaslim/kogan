require_relative 'base'

module Kogan
  module Commands
    class Exit < Kogan::Commands::Base
      private

      def is_valid?(input)
        input =~ /^exit$/
      end

      def execute(client, input)
        puts "Do you mean quit?"
      end
    end
  end
end
