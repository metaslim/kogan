require_relative 'base'

module Kogan
  module Commands
    class Help < Kogan::Commands::Base
      private

      def is_valid?(input)
        input =~ /^help$/
      end

      def execute(client, input)
        puts "ENTER COMMAND [average category, help, list_category, quit]"
      end
    end
  end
end
