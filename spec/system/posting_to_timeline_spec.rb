require 'rails_helper'

describe 'posting new stuff to the timeline' do
  include PageObjects::Helpers

  let(:timeline_page)   { PageObjects::TimelinePage.new }
  let(:form)            { timeline_page.posts_section.new_post_form }
  let(:user_attributes) { attributes_for :user }
  let(:post_attributes) { attributes_for :post }

  before do
    stub_poopfilter
    register_user(user_attributes, keep_logged_in: true)
  end

  it 'posts new stuff to the timleine' do
    timeline_page.load

    # Let's post something
    form.body_field.set(post_attributes[:body])
    form.click_on "Create Post"

    expect(timeline_page).to be_displayed

    # The first article.post element is the new post form, so our new
    # post should be the second one.
    post = timeline_page.posts_section.posts.second

    expect(post.body).to have_text(post_attributes[:body])
    expect(post.meta).to have_text(user_attributes[:full_name])
  end

  it 'automatically enables and disables the submit button', js: true do
    timeline_page.load

    expect(form.button).to be_disabled
    form.body_field.set(post_attributes[:body])
    expect(form.button).to_not be_disabled
    form.body_field.set("")
    expect(form.button).to be_disabled
  end
end
