collection @conversations
attributes :product_id, :offer

child(:audience_one, if: lambda {|c| @product.user.id != c.audience_one.id } ) do
  attributes :id, :full_name, :facebook_avatar
end

child(:audience_two, if: lambda {|c| @product.user.id != c.audience_two.id } ) do
  attributes :id, :full_name, :facebook_avatar
end

node(:latest_update) { |c| c.updated_at.to_i }