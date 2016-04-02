class AddSubToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :sub, index: true, foreign_key: true
  end
end
