collection @comments

attributes :id, :content

child(:user) do
  attributes :id, :full_name, :avatar, :email, :username, :udid, :facebook_id, :facebook_avatar
end