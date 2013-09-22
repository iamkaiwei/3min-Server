require 'faker'

(1..10).each do
	Category.create(:name => Faker::Lorem.word)
end
