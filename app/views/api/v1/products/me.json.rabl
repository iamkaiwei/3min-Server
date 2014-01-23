collection @products
attributes :id, :name, :description, :price, :sold_out

node(:create_time) { |p| p.created_at.to_i }
node(:update_time) { |p| p.updated_at.to_i }

child(:images) do |image|
  attributes :id, :name, :description, :created_at, :updated_at

  node(:thumb) { |img| img.content.url(:thumb) }
  node(:square) { |img| img.content.url(:square) }
  node(:medium) { |img| img.content.url(:medium) }
  node(:origin) { |img| img.content.url }
end

child(:category) do
  extends "api/v1/categories/show"
end