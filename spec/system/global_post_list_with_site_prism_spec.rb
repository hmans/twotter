require 'rails_helper'

# see spec/support/site_prism.rb

describe 'global post page', js: true do
  before { stub_poopfilter }

  let!(:alice) { create(:user, full_name: "Alice Foo") }
  let!(:bob) { create(:user, full_name: "Bob Foo") }
  let!(:alices_post) { create(:post, user: alice, body: "Hi, I'm Alice!") }
  let!(:bobs_post) { create(:post, user: bob, body: "And I'm Bob!") }

  subject(:global_page) { PageObjects::GlobalPage.new }

  specify 'it lists all posts by all users' do
    global_page.load

    expect(global_page).to have_posts_section

    expect(global_page.posts_section).to have_posts(count: 2)

    # Bob's post is the newest, so it should be first...
    global_page.posts_section.posts.first.tap do |post|
      expect(post.body).to have_text(bobs_post.body)
      expect(post.meta).to have_text(bob.full_name)
    end

    # ...followed by Alice's post.
    global_page.posts_section.posts.second.tap do |post|
      expect(post.body).to have_text(alices_post.body)
      expect(post.meta).to have_text(alice.full_name)
    end
  end
end
