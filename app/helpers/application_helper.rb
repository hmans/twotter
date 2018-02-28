module ApplicationHelper
  def gravatar(user)
    gravatar_image_tag(user.email, alt: user.full_name)
  end
end
