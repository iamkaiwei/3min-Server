FactoryGirl.define do
  factory :feedback do
    content "MyString"
    status { %w(negative positive normal) }
    user_id 1
  end
end
