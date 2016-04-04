class Link < ActiveRecord::Base
  paginates_per 10

  belongs_to :sub
  belongs_to :user
  has_many :votes

  before_validation :url_has_proper_prefix
  validates :title, :url, :summary, :user, :sub, presence: true
  validates :url, uniqueness: { case_sensitive: false }
  validate :url, :format => { with: /\Ahttps?:\/\//}

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

end
