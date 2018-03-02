class User < ApplicationRecord
  # Some basic validations for our attributes.
  validates :name,
    presence: true,
    uniqueness: true

  validates :full_name,
    presence: true

  validates :email,
    presence: true,
    uniqueness: true

  # This enables #password= and the automatic hashing.
  has_secure_password

  # Establish a relation to this user's posts.
  has_many :posts,
    -> { order(created_at: :desc) },
    dependent: :destroy

  include CanFollowAndUnfollow

  def timeline_posts
    # NOTE: it may be tempting to use #followed_users_posts here, but
    # those don't include our own posts. So let's do this instead:
    Post.where(user_id: followed_user_ids + [id])
  end
end
