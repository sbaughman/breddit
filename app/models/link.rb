class Link < ActiveRecord::Base
  paginates_per 10

  belongs_to :sub
  belongs_to :user
  has_many :votes

  validates :title, :url, :summary, :user, :sub, presence: true
  validates :url, uniqueness: { case_sensitive: false }

end
