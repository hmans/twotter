require 'rails_helper'

describe 'global post page', js: true do
  before { stub_poopfilter }
  
  let!(:alice) { create(:user, full_name: "Alice Foo") }
  let!(:bob) { create(:user, full_name: "Bob Foo") }
  let!(:alices_post) { create(:post, user: alice, body: "Hi, I'm Alice!") }
  let!(:bobs_post) { create(:post, user: bob, body: "And I'm Bob!") }

  specify 'it lists all posts by all users' do
    visit '/global'
    expect(page).to have_css 'section.posts'

    within 'section.posts' do
      expect(page).to have_css 'article.post',
        id: "post_#{alices_post.id}",
        text: "Hi, I'm Alice!"

      expect(page).to have_css 'article.post',
        id: "post_#{bobs_post.id}",
        text: "And I'm Bob!"
    end
  end
end
