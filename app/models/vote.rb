class Vote < ActiveRecord::Base
  belongs_to :link

  after_save :update_votes

  def update_votes
    karma_score = Vote.where(:link_id => self.link_id).sum(:value)
    self.link.update!(karma: karma_score)
  end

end
