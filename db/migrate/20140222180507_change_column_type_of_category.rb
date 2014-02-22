class ChangeColumnTypeOfCategory < ActiveRecord::Migration
  def change
    rename_column :categories, :type, :specific_type
  end
end
