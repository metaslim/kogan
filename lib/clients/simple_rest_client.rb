require 'rest-client'

module Kogan
  module Clients
    class SimpleRestClient
      attr_reader :rest_client, :base_url, :commands

      def initialize(base_url)
        @rest_client = RestClient
        @base_url = base_url
        @commands = []
      end

      def get(input)
        rest_client.get("#{base_url}#{input}")
      end

      def add_command(command)
        commands << command
        self
      end

      def execute(input)
        commands.each do |command|
          command.run(self, input)
        end
      end
    end
  end
end
