module ApplicationHelper
  def gravatar(user)
    gravatar_image_tag(user.email, alt: user.full_name, class: 'gravatar')
  end
end
