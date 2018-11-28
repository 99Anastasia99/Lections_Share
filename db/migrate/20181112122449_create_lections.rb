class CreateLections < ActiveRecord::Migration[5.2]
  def change
    create_table :lections do |t|
      t.string :title
      t.string :description
      t.integer :speciality
      t.text :body

      t.timestamps
    end
  end
end
