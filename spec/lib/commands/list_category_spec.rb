describe "result" do
  let(:client) {
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    Kogan::Clients::SimpleRestClient.new(base_url).add_command(Kogan::Commands::ListCategory.new)
  }

  it "shows category list" do
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
end
