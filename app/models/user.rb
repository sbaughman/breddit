class User < ActiveRecord::Base
  paginates_per 10
  has_many :links
  has_secure_password
  validates :username, :name, :email, :bio, presence: true
  validates :name, uniqueness: true
  validates :username, format: { without: /\s/ }

end
