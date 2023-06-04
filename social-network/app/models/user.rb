class User < ApplicationRecord
  include Clearance::User

  has_many :posts, dependent: :destroy
  has_many :friendship_requests, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_one :profile, dependent: :destroy
end
