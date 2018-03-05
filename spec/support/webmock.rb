require 'webmock/rspec'

module APIStubs
  module_function

  def stub_poopfilter
    stub_request(:any, %r{poopfilter.herokuapp.com/filter}).to_return do |request|
      input = request.uri.query_values["text"]

      {
        status: 200,
        headers: { content_type: 'application/json' },
        body: { "output" => input }.to_json
      }
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  config.before(:each, type: :system) do
    APIStubs.stub_poopfilter
  end
end