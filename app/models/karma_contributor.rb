class KarmaContributor < ActiveRecord::Base
  self.abstract_class = true

  def update_karma
    vote_score = Vote.where(:link_id => self.link_id).sum(:value)
    click_score = Click.where(:link_id => self.link_id).sum(:value)
    karma_score = (vote_score + click_score) / 5
    self.link.update!(karma: karma_score)
  end

end
