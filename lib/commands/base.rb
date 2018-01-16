require 'json'

module Kogan
  module Commands
    class Base
      attr_reader :products, :product_per_category, :commands

      def run(client, input)
        return unless is_valid?(input)
        begin
          execute(client, input)
        rescue => e
          puts "Caught exception #{e}!"
        end
      end

      private

      def get_all_products(client)
        @products = []
        response = JSON.parse(client.get("/api/products/1").body)

        @products += response['objects']

        while not response['next'].nil?
          response = JSON.parse(client.get(response['next']).body)
          @products += response['objects']
        end

        @products
      end

      def get_all_categories(client)
        @product_per_category = {}
        @products ||= get_all_products(client)

        @products.each do |product|
          @product_per_category[product["category"]] = [] if @product_per_category[product["category"]].nil?

          @product_per_category[product["category"]] << {
            "title" => product["title"],
            "weight" => product["weight"],
            "size" => product["size"],
          }
        end

        @product_per_category
      end

      def get_all_products_for_category(client, category)
        @product_per_category ||= get_all_categories(client)
        @product_per_category[category]
      end

      def is_valid?(input)
        raise NotImplementedError
      end

      def execute(client, input)
        raise NotImplementedError
      end
    end
  end
end
