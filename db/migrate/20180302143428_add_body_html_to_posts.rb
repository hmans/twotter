class AddBodyHtmlToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :body_html, :text
  end
end
