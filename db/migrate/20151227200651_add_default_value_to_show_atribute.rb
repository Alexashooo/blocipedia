class AddDefaultValueToShowAtribute < ActiveRecord::Migration
  def change
    change_column :users, :subscribed, :boolean, :default => false
  end
end
