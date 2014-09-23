FactoryGirl.define do
	factory :user do
    email { Faker::Internet.email }
    password "admin2359"
    full_name { Faker::Name.name }
	end
end
