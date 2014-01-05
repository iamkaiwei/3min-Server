# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation_reply do
    conversation_id 1
    user_id 1
    reply "MyText"
  end
end
