class ChangeColumnLikesOfProduct < ActiveRecord::Migration
  def change
    change_column :products, :likes, :integer, default: 0
  end
end
