require 'rails_helper'

describe 'new user registration' do
  subject(:home_page)     { PageObjects::HomePage.new }

  let(:registration_page) { PageObjects::RegistrationPage.new }
  let(:timeline_page)     { PageObjects::TimelinePage.new }
  let(:user_attributes)   { attributes_for :user }

  it 'works' do
    home_page.load
    home_page.navigation.click_on 'Create Account'

    expect(registration_page).to be_displayed
    expect(registration_page.page_title).to have_text("Create New Account")

    registration_page.fill_form(user_attributes)

    expect(timeline_page).to be_displayed
    expect(timeline_page.flashes.text).to eq("Welcome to TWOTTER!")
  end
end
