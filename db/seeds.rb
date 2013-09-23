require 'faker'

image_file_names = Dir.entries("#{Rails.root.to_s}/public/sample_images").delete_if { |item| item == "." or item == ".." }
image_location = "#{Rails.root}/public/sample_images"

# Sample users
user = User.create(:email => Faker::Internet.email, :facebook_id => Faker::Lorem.characters(32),
			:username => Faker::Lorem.word, :full_name => Faker::Name.name,
			:gender => %W(male female).sample, :birthday => Date.today, :udid => Faker::Lorem.characters(32))
user.image = Image.create(:content => File.new("#{image_location}/#{image_file_names.first}"))

# Sample categories
(1..5).each do
	category = Category.create(:name => Faker::Lorem.word, :description => Faker::Lorem.paragraph(5))
	category.image = Image.create(:content => File.new("#{image_location}/#{image_file_names.last}"))
end

# Sample products
Category.pluck(:id).each do |category_id|
	product = Product.create(:name => Faker::Lorem.word, :user_id => 1, :category_id => category_id,
				   :description => Faker::Lorem.paragraph(5), :price => Random.rand(100..5000),
				   :likes => Random.rand(1000), :dislikes => Random.rand(1000))

	image_file_names.each do |file_name|
		puts "file_name: #{file_name}"
		product.images.create(:content => File.new("#{image_location}/#{file_name}"))
	end
end

