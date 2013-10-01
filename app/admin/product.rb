ActiveAdmin.register Product do
	index do
		%I(id name).each{ |col| column col }
		column :price do |product|
			number_to_currency(product.price, :unit => "$")
		end
		column :images do |product|
			output = []
			if product.images.present?
				product.images.each do |image|
					output << link_to("#{image_tag(image.content.url(:thumb))}".html_safe, admin_image_path(image))
				end
			end
			output.join("&nbsp;&nbsp;&nbsp;").html_safe
		end
		column :owner do |product|
			link_to(product.user.username, admin_user_path(product.user))
		end
		column :category do |product|
			link_to(product.category.name, admin_category_path(product.category))
		end

		default_actions
	end

	show do |product|
		attributes_table do
			%I(id name description likes dislikes created_at updated_at).each{ |r| row r }
			row :sold_out do
				product.sold_out ? "Yes" : "No"
			end
			row :owner do
				link_to(product.user.username, admin_user_path(product.user))
			end
			row :category do
				link_to(product.category.name, admin_category_path(product.category))
			end
			row :images do
				output = []
				if product.images.present?
					product.images.each do |image|
						output << link_to("#{image_tag(image.content.url(:small))}".html_safe, admin_image_path(image))
					end
				end
				output.join("&nbsp;&nbsp;&nbsp;").html_safe
			end
			row :comments do
				output = []
				if product.comments.present?
					product.comments.each do |comment|
						user = User.find_by_id(comment["author_id"])
						output << "#{link_to(user, admin_user_path(user))}:&nbsp;#{comment["content"]}"
					end
				end
				output.join("<br>").html_safe
			end
		end
	end
end
