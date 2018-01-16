require_relative '../../../lib/clients/simple_rest_client'

describe "result" do
  let(:client) {
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    Kogan::Clients::SimpleRestClient.new(base_url)
  }

  it "raise exception" do
    WebMock.allow_net_connect!
    expect {
      VCR.turned_off {
        client.get("/api/products/100")
      }
      WebMock.disable_net_connect!
    }.to raise_exception(RestClient::NotFound)
  end

  it "should not raise exception" do
    WebMock.allow_net_connect!
    expect {
      VCR.turned_off {
        client.get("/api/products/1").code
      }
      WebMock.disable_net_connect!
    }.not_to raise_exception
  end
end
