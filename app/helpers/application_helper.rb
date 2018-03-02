module ApplicationHelper
  def gravatar(user)
    gravatar_image_tag(user.email, alt: user.full_name, class: 'gravatar')
  end

  def formatify(input)
    Formatter.markdown_to_html(input, self)
  end
end
