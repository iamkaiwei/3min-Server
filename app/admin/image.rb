ActiveAdmin.register Image do
	index do
		%I(id name description).each{ |col| column col }
		column :content do |image|
			link_to("#{image_tag(image.content.url(:thumb))}".html_safe, image.content.url(:original), :target => "_blank")
		end
		column :subject do |image|
			if image.attachable.present?
				class_name = image.attachable.class.to_s
				link_to("#{class_name} ##{image.attachable_id}", send("admin_#{class_name.downcase}_path".to_sym, image.attachable))
			end
		end

		default_actions
	end

	show do |image|
		attributes_table do
			%I(id name description created_at updated_at).each{ |r| row r }
			row :subject do
				if image.attachable.present?
					class_name = image.attachable.class.to_s
					link_to("#{class_name} ##{image.attachable_id}", send("admin_#{class_name.downcase}_path".to_sym, image.attachable))
				end
			end
			row :content do
				link_to("#{image_tag(image.content.url(:medium))}".html_safe, image.content.url(:original), :target => "_blank")
			end
		end
	end
end
