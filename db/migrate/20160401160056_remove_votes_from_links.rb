class RemoveVotesFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :votes, :integer
    add_column :links, :karma, :integer, :default => 0
  end
end
