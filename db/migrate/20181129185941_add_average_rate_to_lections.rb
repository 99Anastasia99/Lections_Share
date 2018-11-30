class AddAverageRateToLections < ActiveRecord::Migration[5.2]
  def change
    add_column :lections, :average_rate, :float, :default => 0
  end
end
