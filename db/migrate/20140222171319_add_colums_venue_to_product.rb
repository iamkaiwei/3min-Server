class AddColumsVenueToProduct < ActiveRecord::Migration
  def change
    add_column :products, :venue_id, :string
    add_column :products, :venue_name, :string
    add_column :products, :venue_long, :float
    add_column :products, :venue_lat, :float
  end
end
