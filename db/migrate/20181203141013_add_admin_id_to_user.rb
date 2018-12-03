class AddAdminIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin_as_user, :integer, :default => 0
  end
end
