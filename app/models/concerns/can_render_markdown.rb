module CanRenderMarkdown
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def render_markdown(field_name, to: nil)
      before_save do
        to ||= "#{field_name}_html"
        changed_name = "#{field_name}_changed?"

        if send(changed_name)
          field_value = send(field_name)
          send("#{to}=", Formatter.new(send(field_name), ERB::Util).escape.to_html)
        end
      end
    end
  end
end
