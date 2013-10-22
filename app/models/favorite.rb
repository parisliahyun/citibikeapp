class Favorite < ActiveRecord::Base
  validates :address, :presence => true, :uniqueness => true

  belongs_to :user
end