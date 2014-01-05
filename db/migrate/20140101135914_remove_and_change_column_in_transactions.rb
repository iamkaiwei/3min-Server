class RemoveAndChangeColumnInTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :chat, :hstore
    remove_column :transactions, :meetup_place, :string
    add_column :transactions, :meetup_place_lon, :float
    add_column :transactions, :meetup_place_lat, :float
    add_column :transactions, :price_offer, :float
    add_column :transactions, :completed, :boolean
  end
end
