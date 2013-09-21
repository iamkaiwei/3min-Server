class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :photo_url
    end

	add_index :categories, :name
  end
end
