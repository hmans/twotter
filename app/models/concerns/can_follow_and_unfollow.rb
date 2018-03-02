concern :CanFollowAndUnfollow do
  included do
    # Establish a relation to the users this user is following,
    # through our join model "Following".
    has_many :followings

    has_many :followed_users,
      through: :followings

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
  end
  
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
end
