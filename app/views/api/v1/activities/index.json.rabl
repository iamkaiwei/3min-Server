collection @activities
attributes :id, :content, :subject_id, :subject_type

node(:update_time) { |a| a.updated_at.to_i }

child(:sender) do
  attributes :id, :full_name, :facebook_avatar, :email, :username, :udid, :facebook_id
end
