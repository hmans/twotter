class Formatter
  def initialize(input, view)
    @input = input
    @view = view
  end

  def escape
    @input = @view.send(:html_escape, @input)
    self
  end

  def to_html
    kramdown_document.to_html.html_safe
  end

  private

  def kramdown_document
    Kramdown::Document.new(@input)
  end
end
