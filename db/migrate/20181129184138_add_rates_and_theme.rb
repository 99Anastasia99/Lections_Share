class AddRatesAndTheme < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.references :user, foreign_key: true
      t.references :lection, foreign_key: true
    end
    add_column :users, :theme, :string, default: "light"
  end
end
