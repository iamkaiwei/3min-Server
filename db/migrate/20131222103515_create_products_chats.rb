class CreateProductsChats < ActiveRecord::Migration
  def change
    create_table :products_chats do |t|
      t.integer :product_id
      t.integer :chat_id
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
