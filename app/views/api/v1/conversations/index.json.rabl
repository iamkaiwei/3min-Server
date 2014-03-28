collection @conversations
attributes :id, :product_id, :offer, :latest_message, :channel_name

child(:audience_one, if: lambda {|c| current_api_user.id != c.audience_one.id } ) do
  attributes :id, :full_name, :facebook_avatar, :email, :username, :udid, :facebook_id
end

child(:audience_two, if: lambda {|c| current_api_user.id != c.audience_two.id } ) do
  attributes :id, :full_name, :facebook_avatar, :email, :username, :udid, :facebook_id
end

node(:latest_update) { |c| c.updated_at.to_i }

child(:product) do
  attributes :id, :name, :description, :price, :sold_out, :likes, :venue_id, :venue_name, :venue_long, :venue_lat, :user_id

  child(:images) do |image|
    attributes :id, :name, :description

    node(:thumb) { |img| img.content.url(:thumb) }
    node(:square) { |img| img.content.url(:square) }
    node(:medium) { |img| img.content.url(:medium) }
    node(:origin) { |img| img.content.url }
  end
end




