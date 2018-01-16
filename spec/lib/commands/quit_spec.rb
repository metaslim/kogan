describe "result" do
  let(:client) {
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    Kogan::Clients::SimpleRestClient.new(base_url).add_command(Kogan::Commands::Quit.new)
  }

  it "quit" do
    expect {
      client.execute 'quit'
    }.to raise_exception(SystemExit)
  end
end
