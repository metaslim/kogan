require_relative '../../../lib/clients/simple_rest_client'

describe "result" do
  it "raise_exception" do
    base_url = "http://wrongurlfortesting.com.au"
    expect {
      Kogan::Clients::SimpleRestClient.new(base_url).get("/api/products/1").body
    }.to raise_exception(Exception)
  end
end
