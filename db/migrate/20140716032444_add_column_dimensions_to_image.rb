class AddColumnDimensionsToImage < ActiveRecord::Migration
  def change
    add_column :images, :dimensions, :string, limit: 30
  end
end
