require 'vcr'
require 'webmock/rspec'

require_relative '../lib/clients/simple_rest_client'
require_relative '../lib/commands/command_pack'

WebMock.disable_net_connect!(allow_localhost: true)
VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
end

describe "result" do
  let(:client) {
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    Kogan::Clients::SimpleRestClient.new(base_url)
  }

  it "shows help" do
    client.add_command(Kogan::Commands::Help.new)
    expect {
      client.execute 'help'
    }.to output("ENTER COMMAND [average category, help, list_category, quit]\n").to_stdout
  end

  it "quit" do
    client.add_command(Kogan::Commands::Quit.new)
    expect {
      client.execute 'quit'
    }.to raise_exception(SystemExit)
  end

  it "tells user to use quit instead" do
    client.add_command(Kogan::Commands::Exit.new)
    expect {
      client.execute 'exit'
    }.to output("Do you mean quit?\n").to_stdout
  end

  it "shows category list" do
    client.add_command(Kogan::Commands::ListCategory.new)
    output = <<~OUPUT
      Gadgets
      Air Conditioners
      Batteries
      Cables & Adapters
      Oral Care
      Food Preparation
      Scooters, Bicycles & Tricycles
      Fitness Equipment
      Automotive Accessories
      LED Televisions
      Carpet & Steam Cleaners
      Vacuum Cleaners
      Holders & Stands
      SIM Cards
      Prepaid Plans
      Wall Mounts
      Networking & Wireless
      Travel Adapters
      Travel Accessories
      Pest Control
      Android Phones
      Shoes
    OUPUT

    VCR.use_cassette('kogan/list_category') do
      expect {
        client.execute 'list_category'
      }.to output(/#{Regexp.escape(output)}/).to_stdout
    end
  end

  it "shows correct average for Air Conditioners" do
    client.add_command(Kogan::Commands::Average.new)
    VCR.use_cassette('kogan/average') do
      expect {
        client.execute 'average Air Conditioners'
      }.to output("Average cubic weight for all products in Air Conditioners category is 41.61 kg\n").to_stdout
    end
  end

  it "shows 0 as average for SIM Cards" do
    client.add_command(Kogan::Commands::Average.new)
    VCR.use_cassette('kogan/average') do
      expect {
        client.execute 'average SIM Cards'
      }.to output("Average cubic weight for all products in SIM Cards category is 0.0 kg\n").to_stdout
    end
  end

  it "shows error message for wrong category" do
    client.add_command(Kogan::Commands::Average.new)
    VCR.use_cassette('kogan/average') do
      expect {
        client.execute 'average Food'
      }.to output("Food is invalid category\n").to_stdout
    end
  end
end
