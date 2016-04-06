class CleansedString

  attr_accessor :name

  def initialize(name)
    self.name = name
    cleanse
  end

  def cleanse
    name_to_s
    downcase_name
    remove_spaces
    sanitize
  end

  def name_to_s
    self.name = name.to_s
  end

  def downcase_name
    name.downcase!
  end

  def remove_spaces
    name.gsub!(/\s/, "_")
  end

  def sanitize
    self.name = URI.escape(name, "!?&")
  end

  def to_s
    name
  end

end
