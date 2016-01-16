class RemovePublicFromWikis < ActiveRecord::Migration
  def change
    remove_column :wikis, :public, :boolean
  end
end
