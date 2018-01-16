require_relative 'base'
require 'json'

module Kogan
  module Commands
    class Quit < Kogan::Commands::Base
      def is_valid?(input)
        input =~ /^quit$/
      end

      def execute(client, input)
        exit(0)
      end
    end
  end
end
