class AddLikesToComments < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string  :liker_type
      t.integer :liker_id
      t.string  :likeable_type
      t.integer :likeable_id
    end
      add_column :users, :likees_count, :integer, :default => 0
      add_column :comments, :likers_count, :integer, :default => 0

      add_index :likes, ["liker_id", "liker_type"],       :name => "fk_likes"
      add_index :likes, ["likeable_id", "likeable_type"], :name => "fk_likeables"
    end
  end
