require 'capybara-inline-screenshot/rspec'

RSpec.configure do |config|
  # Configure new Rails 5.1+ system specs. Out of the box, Rails will
  # always use Selenium (with Chrome) for all system specs. If you want
  # a similar behavior as with feature specs (where Selenium is only used
  # for examples tagged with 'js'), you can do the following:
  #
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
