class Click < KarmaContributor
  belongs_to :link
  belongs_to :user

  after_save :update_karma

end
