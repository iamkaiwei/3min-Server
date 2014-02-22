class AddColumnTypeToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :type, :string, limit: 20
  end
end
