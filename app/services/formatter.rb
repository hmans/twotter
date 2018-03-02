module Formatter
  module_function

  def markdown_to_html(input, view)
    Kramdown::Document.new(view.send(:html_escape, input))
      .to_html
      .html_safe
  end
end
