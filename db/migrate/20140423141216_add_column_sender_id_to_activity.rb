class AddColumnSenderIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :sender_id, :integer
    add_index :activities, :user_id
  end
end
