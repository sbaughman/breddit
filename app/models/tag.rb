class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :links, through: :taggings
  before_validation :cleanse_input

  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end

  def cleanse_input
    self.name = CleansedString.new(name).to_s
  end

end
