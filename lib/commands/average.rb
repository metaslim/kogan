require_relative 'base'
require 'json'

module Kogan
  module Commands
    class Average < Kogan::Commands::Base
      def is_valid?(input)
        input =~ /^average\s+?.*$/
      end

      def execute(client, input)
        puts get_all_categories(client)
      end
    end
  end
end
