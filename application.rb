require_relative 'lib/clients/simple_rest_client'
require_relative 'lib/commands/commands_pack'

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
    client.add_command(Kogan::Commands::ListCategory.new)
    client.add_command(Kogan::Commands::Average.new)
    client.add_command(Kogan::Commands::Help.new)
    client.add_command(Kogan::Commands::Quit.new)
    client.add_command(Kogan::Commands::Exit.new)
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
