class Sub < ActiveRecord::Base
  has_many :links
  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validate :name_not_a_resource
  before_save :downcase_name

  def name_not_a_resource
    resource_names = RouteRecognizer.new.initial_path_segments
    errors.add(:name, "sub-breddit name not available") if resource_names.include? name
  end

  def downcase_name
    self.name.downcase!
  end

end
