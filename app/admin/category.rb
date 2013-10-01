ActiveAdmin.register Category do
	index do
		%I(id name description).each{ |col| column col }
		column :image do |category|
			link_to("#{image_tag(category.image.content.url(:thumb))}".html_safe, admin_image_path(category.image)) if category.image.present?
		end

		default_actions
	end

	show do |category|
		attributes_table do
			%I(id name description created_at updated_at).each{ |r| row r }
			row :image do
				link_to("#{image_tag(category.image.content.url(:medium))}".html_safe, admin_image_path(category.image)) if category.image.present?
			end
		end
	end
end
