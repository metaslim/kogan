require_relative 'base'
require 'json'

module Kogan
  module Commands
    class Average < Kogan::Commands::Base
      private

      def is_valid?(input)
        input =~ /^average\s+?.*$/
      end

      def execute(client, input)
        command, category = input.match(/^(average)\s+?(.*)$/).captures
        products_for_category = get_all_products_for_category(client, category)

        total_volume = get_volume(products_for_category)
        total_cubic_weight = get_cubic_weight(total_volume)
        average = get_average(total_cubic_weight, products_for_category.size).round(2)

        puts "Average cubic weight for all products in #{category} category is #{average} kg"
      end

      def get_volume(category)
        category.inject(0) do |volume, product|
          width, length, height = product["size"].values
          volume += width * length * height
          volume.to_f / 1000000
        end
      end

      def get_cubic_weight(volume)
        volume.to_f * 250
      end

      def get_average(cubic_weight, size)
        cubic_weight.to_f / size
      end
    end
  end
end
