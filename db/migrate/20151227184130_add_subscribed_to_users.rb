class AddSubscribedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed, :boolean
    add_column :users, :strip_id, :string
  end
end
