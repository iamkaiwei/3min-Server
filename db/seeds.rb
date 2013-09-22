require 'faker'

# Sample users
(1..5).each do
	User.create(:email => Faker::Internet.email, :password => "password")
end

# Sample categories
(1..5).each do
	Category.create(:name => Faker::Lorem.word)
end

# Sample products
User.pluck(:id).each do |user_id|
	Category.pluck(:id).each do |category_id|
		Product.create(:name => Faker::Lorem.word, :user_id => user_id, :category_id => category_id)
	end
end

