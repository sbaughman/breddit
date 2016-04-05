class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
  validates :content, presence: true
end
