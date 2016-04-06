class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
  validates :content, :user, :link, presence: true
end
