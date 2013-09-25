collection @users
attributes *User.column_names

child(:image) do |image|
	attributes :id, :name, :description, :created_at, :updated_at

	node(:url) { |img| img.content.url }
end
