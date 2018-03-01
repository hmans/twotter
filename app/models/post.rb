class Post < ApplicationRecord
  paginates_per 20

  belongs_to :user

  validates :body,
    presence: true,
    length: { within: 1..280 }

  scope :latest,
    -> { order(created_at: :desc) }
end
