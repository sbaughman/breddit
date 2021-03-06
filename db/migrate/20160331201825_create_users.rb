class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.integer :karma, :default => 0

      t.timestamps null: false
    end
  end
end
