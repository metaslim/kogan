describe "result" do
  let(:client) {
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    Kogan::Clients::SimpleRestClient.new(base_url).add_command(Kogan::Commands::Help.new)
  }

  it "shows help" do
    expect {
      client.execute 'help'
    }.to output("ENTER COMMAND [average category, help, list_category, quit]\n").to_stdout
  end
end
