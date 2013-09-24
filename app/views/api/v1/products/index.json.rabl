collection @products
attributes *Product.column_names

child(:images) do |image|
	attributes :id, :name, :description, :created_at, :updated_at

	node(:url) { |img| img.content.url }
end
