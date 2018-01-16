require_relative '../../../lib/clients/simple_rest_client'

describe "result" do
  it "raise_exception" do
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    WebMock.allow_net_connect!
    expect {
      VCR.turned_off {
        Kogan::Clients::SimpleRestClient.new(base_url).get("/api/products/100")
      }
      WebMock.disable_net_connect!
    }.to raise_exception(RestClient::NotFound)
  end

  it "raise_exception" do
    base_url = "http://wp8m3he1wt.s3-website-ap-southeast-2.amazonaws.com"
    WebMock.allow_net_connect!
    expect {
      VCR.turned_off {
        Kogan::Clients::SimpleRestClient.new(base_url).get("/api/products/1").code
      }
      WebMock.disable_net_connect!
    }.not_to raise_exception
  end
end
