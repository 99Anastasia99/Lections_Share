class RemoveRatingChaches < ActiveRecord::Migration[5.2]
  def change
     drop_table :rating_caches
  end
end
