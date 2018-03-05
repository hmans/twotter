require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'when saving' do
    let(:body) { 'a potentially filthy body' }
    let(:filtered_body) { 'filtered body' }
    subject(:post) { build :post, user: create(:user), body: body }

    it 'invokes the PoopFilter to filter filth from the user input' do
      # Set up a spy
      allow(PoopFilter)
        .to receive(:filter)
        .and_return(filtered_body)

      # Save the post
      post.save!

      # Was the filter invoked?
      expect(PoopFilter)
        .to have_received(:filter)
        .with(body)

      # Was the value on the post set correctly?
      expect(post.body).to eq(filtered_body)
    end
  end
end
