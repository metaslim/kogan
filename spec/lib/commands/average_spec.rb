describe "result" do
  let(:client) {
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    Kogan::Clients::SimpleRestClient.new(base_url)
  }

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
