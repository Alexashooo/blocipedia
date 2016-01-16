class ChangePrivateName < ActiveRecord::Migration
  def change
    rename_column :wikis, :private, :public
  end
end
