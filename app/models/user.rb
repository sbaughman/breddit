class User < ActiveRecord::Base
  paginates_per 10
  has_many :links
  has_many :votes
  has_many :clicks
  has_many :comments
  has_many :voted_links, :through => :votes, :source => 'link'
  has_many :clicked_links, :through => :clicks, :source => 'link'
  has_many :commented_links, :through => :comments, :source => 'link'
  has_secure_password
  validates :username, :name, :email, :bio, presence: true
  validates :username, uniqueness: true
  validates :username, format: { without: /\s/ }

end
