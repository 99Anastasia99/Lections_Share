class AddRatingToLection < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :rating, :default => 0
      t.references :user, foreign_key: true
      t.references :lection, foreign_key: true
    end
  end
end
