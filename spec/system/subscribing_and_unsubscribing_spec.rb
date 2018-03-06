require 'rails_helper'

describe 'subscribing to and unsubscribing from users' do
  include PageObjects::Helpers

  let(:global_page)   { PageObjects::GlobalPage.new }
  let(:timeline_page) { PageObjects::TimelinePage.new }
  let(:profile_page)  { PageObjects::ProfilePage.new }
  let(:alice)         { attributes_for(:user, full_name: "Alice Arnold") }
  let(:bob)           { attributes_for(:user, full_name: "Bob Barnes") }

  before do
    stub_poopfilter

    register_user(alice)
    register_user(bob)
  end

  specify do
    login_user(alice[:name], alice[:password])
    create_post("Hi, I'm Alice!")
    logout_user

    login_user(bob[:name], bob[:password])

    # After logging in, Bob will see an empty timeline.
    expect(timeline_page).to be_displayed
    expect(timeline_page.posts_section).to have_posts(count: 1) # the form is 1 post

    # Now bob visits the global page...
    click_on "All Posts"

    # ...and sees Alice's posts.
    expect(global_page).to be_displayed
    global_page.posts_section.posts.first.tap do |post|
      expect(post.meta).to have_text("Alice Arnold")
      expect(post.body).to have_text("Hi, I'm Alice!")
    end

    # He likes how Alice thinks, and proceeds to visit her profile...
    click_on "Alice Arnold"
    expect(profile_page).to be_displayed(id: 1)

    # ...sees that noone is following her...
    expect(profile_page).to have_text("Nobody is following @#{alice[:name]}. SAD :-(")

    # ...and clicks the follow button.
    click_on "Follow"

    # Bob is still on Alice's profile, but the text has changed.
    expect(profile_page).to be_displayed(id: 1)
    expect(profile_page).to_not have_text("Nobody is following @#{alice[:name]}. SAD :-(")
    expect(profile_page).to have_text("1 Follower")

    # Bob now returns to his timeline...
    click_on "Timeline"

    # ...and sees Alice's post.
    timeline_page.posts_section.posts.second.tap do |post|
      expect(post.meta).to have_text("Alice Arnold")
      expect(post.body).to have_text("Hi, I'm Alice!")
    end

    # But now Bob changes his mind and decides to unfollow Alice again.
    click_on "Alice Arnold"
    expect(profile_page).to be_displayed(id: 1)
    click_on "Unfollow"
    click_on "Timeline"

    # Bob's timeline should now be empty again. (The first article.post element
    # is the new post form.)
    expect(timeline_page.posts_section).to have_posts(count: 1)
  end
end
