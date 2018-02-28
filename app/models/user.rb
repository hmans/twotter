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

  # Now this is possible, yay:
  has_many :followed_users_posts,
    through: :followed_users,
    source: :posts

  def timeline_posts
    # NOTE: it may be tempting to use #followed_users_posts here, but
    # those don't include our own posts. So let's do this instead:
    Post.where(user_id: followed_user_ids + [id])
  end
end
