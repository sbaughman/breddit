class Sub < ActiveRecord::Base
  has_many :links

  before_save :downcase_name

  def downcase_name
    self.name.downcase!
  end

end
