require_relative 'base'

module Kogan
  module Commands
    class Average < Kogan::Commands::Base
      CUBIC_WEGHT_CONVERSION_FACTOR = 250
      CM3_TO_M3 = 1000000

      private

      def is_valid?(input)
        input =~ /^average\s+?.*$/
      end

      def execute(client, input)
        command, category = input.match(/^(average)\s+?(.*)$/).captures
        products_for_category = get_all_products_for_category(client, category)

        begin
          total_volume = get_volume(products_for_category)
          total_cubic_weight = get_cubic_weight(total_volume)
          average = get_average(total_cubic_weight, products_for_category.size)
        rescue
          average = 0
        end

        puts "Average cubic weight for all products in #{category} category is #{average.round(1)} kg"
      end

      def get_volume(category)
        category.inject(0) do |volume, product|
          width, length, height = product["size"].values
          volume += width * length * height
          volume.to_f / CM3_TO_M3
        end
      end

      def get_cubic_weight(volume)
        volume.to_f * CUBIC_WEGHT_CONVERSION_FACTOR
      end

      def get_average(cubic_weight, size)
        cubic_weight.to_f / size
      end
    end
  end
end
