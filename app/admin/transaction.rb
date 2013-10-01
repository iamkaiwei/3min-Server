ActiveAdmin.register Transaction do
	index do
		%I(id meetup_place).each{ |col| column col }
		column :buyer do |transaction|
			link_to(transaction.buyer.username, admin_user_path(transaction.buyer))
		end
		column :seller do |transaction|
			link_to(transaction.seller.username, admin_user_path(transaction.seller))
		end
		column :product do |transaction|
			link_to(transaction.product.name, admin_product_path(transaction.product))
		end

		default_actions
	end

	show do |transaction|
		attributes_table do
			%I(id meetup_place created_at updated_at).each{ |r| row r}
			row :buyer do
				link_to(transaction.buyer.username, admin_user_path(transaction.buyer))
			end
			row :seller do
				link_to(transaction.seller.username, admin_user_path(transaction.seller))
			end
			row :product do
				link_to(transaction.product.name, admin_product_path(transaction.product))
			end
			row :chat do
				output = []
				if transaction.chat.present?
					transaction.chat.each do |message|
						user = User.find_by_id(message["user_id"])
						output << "#{link_to(user, admin_user_path(user))}:&nbsp;#{message["content"]}"
					end
				end
				output.join("<br>").html_safe
			end
		end
	end
end
