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
end
