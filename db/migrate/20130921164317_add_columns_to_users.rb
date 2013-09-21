class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :facebook_id, :string
    add_column :users, :name, :string
    add_column :users, :udid, :string
    add_column :users, :photo_url, :string

	add_index :users, :username
	add_index :users, :facebook_id
	add_index :users, :udid
  end
end
