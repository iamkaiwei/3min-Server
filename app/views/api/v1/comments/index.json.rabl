collection @comments

attributes :id, :content

child(:user) do
  attributes :id, :full_name, :avatar, :email, :username, :udid, :facebook_id, :facebook_avatar
end

node(:created_at) { |c| c.created_at.to_i }
node(:updated_at) { |c| c.updated_at.to_i }