class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :product_id
      t.string :meetup_place
      t.hstore :chat, array: true

	  t.timestamps
    end

	add_index :transactions, :buyer_id
	add_index :transactions, :seller_id
	add_index :transactions, :product_id
  end
end
