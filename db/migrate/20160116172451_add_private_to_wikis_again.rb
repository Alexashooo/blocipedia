class AddPrivateToWikisAgain < ActiveRecord::Migration
  def change
    add_column :wikis, :private, :boolean, default: false, null: false
  end
end
