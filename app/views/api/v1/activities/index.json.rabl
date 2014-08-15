collection @activities
attributes :id, :content, :subject_id, :subject_type, :display_image_url

node(:update_time) { |a| a.updated_at.to_i }

child(:sender) do
  attributes :id, :full_name, :avatar, :email, :username, :udid, :facebook_id, :facebook_avatar
end
