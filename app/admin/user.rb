ActiveAdmin.register User do
	index do
		%I(id username email facebook_id role udid).each{ |col| column col }
		column :image do |user|
			link_to("#{image_tag(user.image.content.url(:thumb))}".html_safe, admin_image_path(user.image))
		end

		default_actions
	end

	show do |user|
		attributes_table do
			%I(id email username facebook_id full_name first_name middle_name last_name gender birthday udid role sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip created_at updated_at).each{ |r| row r }
			row :image do
				link_to("#{image_tag(user.image.content.url(:medium))}".html_safe, admin_image_path(user.image))
			end
		end
	end
end
