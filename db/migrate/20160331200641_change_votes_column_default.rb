class ChangeVotesColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :links, :votes, 0
  end
end
