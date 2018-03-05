require 'rails_helper'

# First, here's how we would spec it with actual HTTP interactions
# happening.
#
describe PoopFilter do
  describe '.filter' do
    # Since we've added webmock and told it to not allow any
    # outside HTTP interactions, we need to specifically allow these
    # for the examples contained in this block.
    #
    before { WebMock.allow_net_connect! }
  
    def execute; PoopFilter.filter(text); end

    context 'when a filthy text is given' do
      let(:text) { 'fuck this shit' }

      it 'removes the filthy words' do
        expect(execute).to eq('**** this ****')
      end
    end

    context 'when a clean text is given' do
      let(:text) { 'happy butterflies' }

      it 'returns the text unmodified' do
        expect(execute).to eq(text)
      end
    end

    context 'when no text is given' do
      let(:text) { nil }

      it 'returns nil' do
        expect(execute).to eq(nil)
      end
    end
  end
end

# Another way of testing this class if we want to stop it from doing
# actual HTTP requests:
#
describe PoopFilter, "but with a stub" do
  describe '.filter' do
    let(:text) { "poop" }
    let(:expected_url) { 'https://poopfilter.herokuapp.com/filter' }
    let(:expected_query) { { text: text } }
    let(:httparty_double) { double(parsed_response: { "output": "****" }) }

    context 'when invoked with a text' do
      it "performs a HTTP POST request to PoopFilter's API" do
        allow(HTTParty)
          .to receive(:post)
          .and_return(httparty_double)

        PoopFilter.filter(text)

        expect(HTTParty)
          .to have_received(:post)
          .with(expected_url, query: expected_query)
      end
    end
  end
end
