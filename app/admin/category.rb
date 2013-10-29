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

	form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :name
      f.input :description
    	f.inputs	:for => [:image, (f.object.image || f.object.build_image)] do |j|
		    j.input :content, :as => :file, :hint => j.template.image_tag(j.object.content.url) 
		  end
    end
    f.buttons
  end

  controller do
    def permitted_params
      params.permit(:category => [:name, :description, image_attributes: [:content, :name, :description]])
    end
  end
end