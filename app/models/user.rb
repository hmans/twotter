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

  # Establish a relation to the users this user is following,
  # through our join model "Following".
  has_many :followings

  has_many :followed_users,
    through: :followings,
    source: :followed_user

  # Establish the reverse relation, ie. to users following this user
  # (aka followers.) For this, we also need to establish a relation to the
  # Followings representing other users following us, and then go
  # through that.
  has_many :follower_followings,
    class_name: 'Following',
    foreign_key: :followed_user_id

  has_many :followers,
    through: :follower_followings,
    source: :user

  # Now it's possible to fetch all posts by followed users with yet another
  # simple has_many relation:
  has_many :followed_users_posts,
    through: :followed_users,
    source: :posts


  def following?(user)
    followed_users.include?(user)
  end
  alias_method :follows?, :following?

  def follow!(user)
    unless following?(user)
      followed_users << user
    end
  end

  def unfollow!(user)
    if following?(user)
      followed_users.delete(user)
    end
  end

  def timeline_posts
    # NOTE: it may be tempting to use #followed_users_posts here, but
    # those don't include our own posts. So let's do this instead:
    Post.where(user_id: followed_user_ids + [id])
  end
end
