class AddPrivateToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :private, :boolean, default: true, null: false
  end
end
