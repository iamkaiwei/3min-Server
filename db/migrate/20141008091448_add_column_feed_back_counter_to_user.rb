class AddColumnFeedBackCounterToUser < ActiveRecord::Migration
  def change
    add_column :users, :positive_count, :integer, default: 0
    add_column :users, :negative_count, :integer, default: 0
    add_column :users, :normal_count, :integer, default: 0
  end
end
