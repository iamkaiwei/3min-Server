class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :content
      t.integer :product_id
      t.integer :user_id
      t.integer :sender_id
      t.string :status

      t.timestamps
    end
  end
end
