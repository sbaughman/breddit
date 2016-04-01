class Link < ActiveRecord::Base
  paginates_per 10

  belongs_to :user

  validates :title, :url, :summary, :user, presence: true
  validates :url, uniqueness: { case_sensitive: false }

end
