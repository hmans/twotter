class Post < ApplicationRecord
  paginates_per 10

  belongs_to :user

  validates :body,
    presence: true,
    length: { within: 1..280 }

  scope :latest,
    -> { order(created_at: :desc) }

  # When saving a post, run the body through PoopFilter.
  before_save do
    if body_changed?
      self.body = PoopFilter.filter(body)
    end
  end

  render_markdown :body
end
