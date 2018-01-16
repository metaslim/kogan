require_relative 'base'
require 'json'

module Kogan
  module Commands
    class Exit < Kogan::Commands::Base
      def is_valid?(input)
        input =~ /^exit$/
      end

      def execute(client, input)
        puts "Do you mean quit?"
      end
    end
  end
end
