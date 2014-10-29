class AddColumnActivitiesCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :activities_count, :integer, default: 0

    User.all.each do |u|
      User.update_counters u.id, activities_count: u.activities.count
    end
  end
end
