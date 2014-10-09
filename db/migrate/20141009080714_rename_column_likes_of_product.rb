class RenameColumnLikesOfProduct < ActiveRecord::Migration
  def change
    rename_column :products, :likes, :likes_count
  end
end
