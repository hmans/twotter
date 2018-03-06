require 'rails_helper'

describe 'posting new stuff to the timeline' do
  include PageObjects::Helpers

  let(:timeline_page)   { PageObjects::TimelinePage.new }
  let(:user_attributes) { attributes_for :user }
  let(:post_attributes) { attributes_for :post }

  before do
    stub_poopfilter
    register_user(user_attributes, keep_logged_in: true)
  end

  specify do
    timeline_page.load

    posts_section = timeline_page.posts_section
    expect(posts_section.new_post_form).to be_visible

    form = posts_section.new_post_form
    form.body_field.set(post_attributes[:body])
    form.click_on "Create Post"

    expect(timeline_page).to be_displayed

    # The first article.post element is the new post form, so our new
    # post should be the second one.
    post = timeline_page.posts_section.posts.second

    expect(post.body).to have_text(post_attributes[:body])
    expect(post.meta).to have_text(user_attributes[:full_name])
  end
end
