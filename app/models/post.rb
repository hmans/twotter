class Post < ApplicationRecord
  paginates_per 10

  belongs_to :user

  validates :body,
    presence: true,
    length: { within: 1..280 }

  scope :latest,
    -> { order(created_at: :desc) }

  render_markdown :body
end
