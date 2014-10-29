object @product
attributes :id, :name, :description, :price, :sold_out, :likes_count, :venue_id, :venue_name, :venue_long, :venue_lat

node(:create_time) { |p| p.created_at.to_i }
node(:update_time) { |p| p.updated_at.to_i }
node(:comments_count) { |p| p.comments.count }

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

child(:user => :owner) do
  extends "api/v1/users/index"
end

child @comments do
  attributes :id, :content

  child(:user) do
    attributes :id, :full_name, :avatar, :email, :username, :udid, :facebook_id, :facebook_avatar
  end

  node(:created_at) { |c| c.created_at.to_i }
  node(:updated_at) { |c| c.updated_at.to_i }
end
