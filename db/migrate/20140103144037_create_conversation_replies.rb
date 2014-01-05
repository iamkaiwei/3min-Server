class CreateConversationReplies < ActiveRecord::Migration
  def change
    create_table :conversation_replies do |t|
      t.integer :conversation_id, null: false
      t.integer :user_id, null: false
      t.text :reply

      t.timestamps
    end
  end
end
