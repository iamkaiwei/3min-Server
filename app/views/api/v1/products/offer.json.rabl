collection @products
attributes :id, :name, :description, :price, :sold_out

node(:offer) { |p| @conversations.detect { |c| c.product_id == p.id }.try(:offer) }
node(:conversation_id) { |p| @conversations.detect { |c| c.product_id == p.id }.try(:id) }

node(:create_time) { |p| p.created_at.to_i }
node(:update_time) { |p| p.updated_at.to_i }

child(:images) do |image|
  attributes :id, :name, :description, :created_at, :updated_at

  node(:thumb) { |img| img.content.url(:thumb) }
  node(:square) { |img| img.content.url(:square) }
  node(:medium) { |img| img.content.url(:medium) }
  node(:origin) { |img| img.content.url }
end

child(:user => :owner) do
  extends "api/v1/users/show"
end