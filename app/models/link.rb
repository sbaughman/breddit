class Link < ActiveRecord::Base
  paginates_per 10

  belongs_to :sub
  belongs_to :user
  has_many :votes
  has_many :clicks
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  before_validation :url_has_proper_prefix
  validates :title, :url, :summary, :user, :sub, presence: true
  validates :url, uniqueness: { case_sensitive: false }
  validates :url, :format => { with: /\Ahttps?:\/\//}

  after_update :update_user_karma

  def update_user_karma
    karma_score = Link.where(:user_id => self.user_id).sum(:karma)
    self.user.update!(karma: karma_score)
  end

  def url_has_proper_prefix
    unless self.url =~ /\Ahttps?:\/\//
      self.url = "http://" + url
    end
  end

  def tag_list
    tags.map { |tag| tag.name }.join(", ")
  end

  def tag_list=(string)
    tag_names = string.split(",").map(&:strip)
    tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name) }
    self.tags = tags
  end

end
