if Rails.env == :production
	User.create(:email => "anhtrantuan.hcmc@gmail.com", :username => "administrator", :password => "P@ssw0rd", :full_name => "Anh Tuan Tran",
				:first_name => "Anh", :middle_name => "Anh", :last_name => "Tran", :gender => "male", :birthday => Date.new(1991, 2, 15))
else
	require 'faker'

	# Sample OAuth applications
	puts "====================================="
	puts "Creating sample OAuth applications..."
	puts "Creating 'ios_app'"
	ios_app = Doorkeeper::Application.create(:name => "ios_app", :redirect_uri => "urn:ietf:wg:oauth:2.0:oob")
	ios_app.uid = "36d9b0cae1fb797b3095ebd8c50ef4b58df47f16d5aa18f96704f4c484136869"
	ios_app.secret = "8eb597435160bcef09084a9bbd32c9d2a309b97b33f2e7284d2ac8c3840a0834"
	ios_app.save
	puts "Created 'ios_app'!"
	puts "====================================="


	image_file_names = Dir.entries("#{Rails.root.to_s}/public/sample_images").delete_if { |item| item == "." or item == ".." }
	image_location = "#{Rails.root}/public/sample_images"


	# Sample users
	puts "========================"
	puts "Creating sample users..."
	puts "Creating 'admin'"
	admin = User.create(:email => Faker::Internet.email, :facebook_id => Faker::Lorem.characters(32),
						:username => "admin", :password => "password", :full_name => Faker::Name.name, :role => "admin",
						:gender => %W(male female).sample, :birthday => Date.today, :udid => Faker::Lorem.characters(32))
	# admin.image = Image.create(:content => File.new("#{image_location}/#{image_file_names.first}"))
	puts "Created 'admin'!"
	puts "Creating 'user1'"
	user = User.create(:email => Faker::Internet.email, :facebook_id => Faker::Lorem.characters(32),
					   :username => "user1", :password => "password", :full_name => Faker::Name.name, :role => "user",
					   :gender => %W(male female).sample, :birthday => Date.today, :udid => Faker::Lorem.characters(32))
	# user.image = Image.create(:content => File.new("#{image_location}/#{image_file_names.last}"))
	puts "Created 'user1'!"
	puts "========================"


	# Sample categories
	puts "============================="
	puts "Creating sample categories..."
	(1..5).each do |i|
		puts "Creating 'cat#{i}'"
		category = Category.create(:name => "cat#{i}", :description => Faker::Lorem.paragraph(5))
		# category.image = Image.create(:content => File.new("#{image_location}/#{image_file_names.last}"))
		puts "Created 'cat#{i}'!"
	end
	puts "============================="


	# Sample products
	puts "=========================="
	puts "Created sample products..."
	Category.pluck(:id).each do |category_id|
		puts "Creating 'prod#{category_id}'"
		product = Product.create(:name => "prod#{category_id}", :user_id => 2, :category_id => category_id,
								 :description => Faker::Lorem.paragraph(5), :price => Random.rand(100..5000),
								 :likes => Random.rand(1000), :dislikes => Random.rand(1000))

		image_file_names.each do |file_name|
			# product.images.create(:content => File.new("#{image_location}/#{file_name}"))
		end
		puts "Created 'prod#{category_id}'!"
	end
	puts "=========================="
end
