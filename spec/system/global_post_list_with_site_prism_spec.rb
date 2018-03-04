require 'rails_helper'

# see spec/support/site_prism.rb

describe 'global post page', js: true do
  let!(:alice) { create(:user, full_name: "Alice Foo") }
  let!(:bob) { create(:user, full_name: "Bob Foo") }
  let!(:alices_post) { create(:post, user: alice, body: "Hi, I'm Alice!") }
  let!(:bobs_post) { create(:post, user: bob, body: "And I'm Bob!") }

  specify 'it lists all posts by all users' do
    @page = PageObjects::GlobalPage.new
    @page.load
    expect(@page).to have_posts_section

    expect(@page.posts_section).to have_posts

    expect(@page.posts_section).to have_css 'article.post',
      id: "post_#{alices_post.id}",
      text: "Hi, I'm Alice!"

    expect(@page.posts_section).to have_css 'article.post',
      id: "post_#{bobs_post.id}",
      text: "And I'm Bob!"
  end
end
