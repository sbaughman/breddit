class Vote < KarmaContributor
  belongs_to :link
  belongs_to :user

  validates :user, :link, presence: true

  after_save :update_karma

end
