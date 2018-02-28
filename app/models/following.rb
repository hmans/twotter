class Following < ApplicationRecord
  belongs_to :user

  belongs_to :followed_user,
    foreign_key: 'followed_user_id',
    class_name: 'User'

  has_many :posts,
    through: :followed_user,
    source: :posts
end
