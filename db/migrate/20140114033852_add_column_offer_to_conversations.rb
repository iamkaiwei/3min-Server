class AddColumnOfferToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :offer, :float
  end
end
