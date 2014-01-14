collection @conversations
attributes :id, :product_id, :offer

child(:audience_one, if: lambda {|c| current_api_user.id != c.audience_one.id } ) do
  attributes :id, :full_name, :facebook_avatar
end

child(:audience_two, if: lambda {|c| current_api_user.id != c.audience_two.id } ) do
  attributes :id, :full_name, :facebook_avatar
end

node(:lastest_message) { |c| c.conversation_replies.last.try(:reply) || "Offered #{c.offer}" }
node(:lastest_update) { |c| c.updated_at.to_i }



