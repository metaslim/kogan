describe "result" do
  let(:client) {
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    Kogan::Clients::SimpleRestClient.new(base_url)
  }

  it "tells user to use quit instead" do
    client.add_command(Kogan::Commands::Exit.new)
    expect {
      client.execute 'exit'
    }.to output("Do you mean quit?\n").to_stdout
  end

end
