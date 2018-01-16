require_relative 'base'

module Kogan
  module Commands
    class ListCategory < Kogan::Commands::Base
      private

      def is_valid?(input)
        input =~ /^list_category$/
      end

      def execute(client, input)
        puts get_all_categories(client).keys
      end
    end
  end
end
