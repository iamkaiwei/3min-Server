class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_one, null: false
      t.integer :user_two, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
