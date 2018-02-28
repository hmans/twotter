class User < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true

  validates :full_name,
    presence: true

  validates :email,
    presence: true,
    uniqueness: true

  has_secure_password

  has_many :posts,
    -> { order(created_at: :desc) },
    dependent: :destroy

  has_many :followings

  has_many :followed_users,
    through: :followings,
    source: :followed_user

  has_many :followed_users_posts,
    through: :followed_users,
    source: :posts
end
