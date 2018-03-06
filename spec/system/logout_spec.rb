require 'rails_helper'

describe 'logging out a user' do
  include PageObjects::Helpers

  let(:user_attributes)   { attributes_for :user, password: 'secret' }
  let(:timeline_page)     { PageObjects::TimelinePage.new }
  let(:global_page)       { PageObjects::GlobalPage.new }

  before do
    register_user(user_attributes, keep_logged_in: true)
  end

  it 'works' do
    timeline_page.load
    timeline_page.navigation.click_on 'Logout'

    expect(global_page).to be_displayed
    expect(global_page.flashes.text).to eq("You have been logged out.")
  end
end
