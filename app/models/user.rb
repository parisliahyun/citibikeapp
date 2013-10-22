class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :trips
  has_secure_password
end