require 'vcr'
require 'webmock/rspec'

require_relative '../lib/clients/simple_rest_client'
require_relative '../lib/commands/command_pack'

WebMock.disable_net_connect!(allow_localhost: true)
VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
end
