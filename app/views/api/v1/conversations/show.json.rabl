object @conversation

attributes :id, :product_id

child(:audience_one => :user_one) do
  attributes :id, :full_name, :facebook_avatar
end

child(:audience_two => :user_two) do
  attributes :id, :full_name, :facebook_avatar
end

child @conversation_replies => :replies do
  attributes :id, :conversation_id, :user_id, :reply
end