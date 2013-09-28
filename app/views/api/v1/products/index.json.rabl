collection @products
attributes *Product.column_names

child(:images) do |image|
	attributes :id, :name, :description, :created_at, :updated_at

	node(:url) { |img| img.content.url }
end

child(:category) do
	extends "api/v1/categories/show"
end

child(:user => :owner) do
	extends "api/v1/users/show"
end
