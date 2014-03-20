object @conversation

attributes :id, :product_id, :offer, :channel_name

child(@recipient) { attributes :id, :full_name, :facebook_avatar }

child @conversation_replies => :replies do
  attributes :id, :conversation_id, :user_id, :reply
  node(:timestamp) { |r| r.created_at.to_i }
end