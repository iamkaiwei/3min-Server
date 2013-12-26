collection @chats
attributes :id, :product_id, :from, :to, :chat_id

node(:message) { |pc| pc.chat.message }
node(:sent_at) { |pc| pc.created_at.to_i }
child :sender, if: proc{ @sender } do |pc|
  attributes :full_name, :facebook_avatar
end


