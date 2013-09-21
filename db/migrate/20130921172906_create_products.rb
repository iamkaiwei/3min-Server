class CreateProducts < ActiveRecord::Migration
  def change
	enable_extension "hstore"

    create_table :products do |t|
      t.integer :user_id
      t.string :name
      t.integer :category_id
      t.text :description
      t.decimal :price
      t.boolean :sold_out, default: false
      t.string :photos_urls, array: true
      t.hstore :comments, array: true
      t.integer :likes
      t.integer :dislikes
    end

	add_index :products, :user_id
	add_index :products, :category_id
	add_index :products, :price
	add_index :products, :sold_out
	add_index :products, :likes
	add_index :products, :dislikes
  end
end
