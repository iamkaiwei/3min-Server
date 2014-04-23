# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    content "MyString"
    subject_id 1
    subject_type "MyString"
    user_id 1
  end
end
