class DropTableChats < ActiveRecord::Migration
  def change
    drop_table :chats
    drop_table :products_chats
  end
end
