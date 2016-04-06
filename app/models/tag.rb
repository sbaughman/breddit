class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :links, through: :taggings

  validates :name, presence: true
end
