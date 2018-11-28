class AddDependencies < ActiveRecord::Migration[5.2]
  def change
    add_reference :lections,:user
  end
end
