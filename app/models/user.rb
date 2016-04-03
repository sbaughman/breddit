class User < ActiveRecord::Base
  has_many :links
  validates :name, :email, :bio, presence: true
  validates :name, uniqueness: true
end
