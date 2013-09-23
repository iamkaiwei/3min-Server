class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string, :unique => true
    add_column :users, :username, :string, :unique => true
    add_column :users, :full_name, :string
	add_column :users, :first_name, :string
	add_column :users, :middle_name, :string
	add_column :users, :last_name, :string
	add_column :users, :gender, :string
	add_column :users, :birthday, :date
    add_column :users, :udid, :string, :unique => true

	add_index :users, :facebook_id
	add_index :users, :username
	add_index :users, :full_name
	add_index :users, :gender
	add_index :users, :birthday
	add_index :users, :udid
  end
end
