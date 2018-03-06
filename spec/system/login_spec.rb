require 'rails_helper'

describe 'logging in a user' do
  include PageObjects::Helpers

  let(:home_page)         { PageObjects::HomePage.new }
  let(:login_page)        { PageObjects::LoginPage.new }
  let(:timeline_page)     { PageObjects::TimelinePage.new }

  let(:user_attributes)   { attributes_for :user, password: 'secret' }

  before do
    register_user(user_attributes)
  end

  specify do
    home_page.load
    home_page.navigation.click_on "Login"

    expect(login_page).to be_displayed
    login_page.fill_form(user_attributes[:name], user_attributes[:password])

    expect(timeline_page).to be_displayed
    expect(timeline_page.flashes.text).to eq("Welcome back!")
  end
end
