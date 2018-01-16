require_relative 'lib/clients/simple_rest_client'
require_relative 'lib/commands/command_pack'

class Main
  BASE_URL = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"

  class << self
    def run
      new.execute
    end
  end

  attr_reader :client

  def initialize
    @client = Kogan::Clients::SimpleRestClient.new(BASE_URL)
  end

  def setup_client_commands
    Kogan::Commands.constants.each do |k|
      if Kogan::Commands.const_get(k).instance_of? Class
        client.add_command(Object.const_get("Kogan::Commands::#{k.to_s}").new) unless k.to_s == 'Base'
      end
    end
  end


  def waiting_for_command
    puts "ENTER COMMAND [average category, help, list_category, quit]"
    command = gets
    loop do
      client.execute command.chomp
      command = gets
    end
  end

  def execute
    setup_client_commands
    waiting_for_command
  end
end

Main.run
