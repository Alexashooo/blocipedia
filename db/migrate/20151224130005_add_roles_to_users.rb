class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_role, :integer
  end
end
