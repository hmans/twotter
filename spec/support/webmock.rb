require 'webmock/rspec'

module APIStubs
  def stub_poopfilter
    stub_request(:any, %r{poopfilter.herokuapp.com/filter}).to_return do |request|
      input = request.uri.query_values["text"]

      {
        status: 200,
        headers: { content_type: 'application/json' },
        body: { "input" => input, "output" => input }.to_json
      }
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    WebMock.disable_net_connect!(allow_localhost: true)
    config.include APIStubs
  end
end
