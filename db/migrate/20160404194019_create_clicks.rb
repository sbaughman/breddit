class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.integer :value, :default => 0
      t.references :link, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
