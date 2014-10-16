class Api::V1::ProductsController < Api::BaseController
	def index
		@products = Product.order(id: :desc).includes(:images, :category, :user)
		@products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
		@products = @products.paginate(:page => params[:page], :per_page => params[:per_page]) if params[:per_page].present? or params[:page].present?
		load_liked_product_ids
	end

	def show
 		@comments = @product.comments.latest_order.limit(3)
  end

	def create
		@product = current_api_user.products.new(product_params)
		return render_failure(:details => @product.errors.full_messages.join("\n")) unless @product.save
		render_success(:product => render_json_rabl(@product, :show))
	end

	def update
		return render_failure(details: "You are not owner of this product") unless @product.user_id == current_api_user.id
		return render_failure(:details => @product.errors.full_messages.join("\n")) unless @product.update(product_params)
		render_success(:product => render_json_rabl(@product, :show))
	end

	def destroy
		@product = Product.find(params[:id])
		return render_failure(details: "You are not owner of this product") unless @product.user_id == current_api_user.id
		@product.destroy ? render_success : render_failure
	end

	def me
		@products = current_api_user.products.order(created_at: :desc).includes(:images, :category, :user)
		@products = @products.paginate(:page => params[:page], :per_page => 10) if params[:page].present?
		load_liked_product_ids
	end

	def offer
		@conversations = Conversation.of_you(current_api_user.id).where.not(offer: nil).to_a
		product_ids = @conversations.map(&:product_id)
		@products = Product.where(id: product_ids).where.not(user_id: current_api_user.id).paginate(:page => params[:page], :per_page => 10) if params[:page].present?
	end

	def liked
		@products = current_api_user.liked_products
		@products = @products.paginate(:page => params[:page], :per_page => 10) if params[:page].present?
	end

	def search
		return render_failure(details: "Please provide tags") if params[:tags].blank?
		tags = params[:tags].split(",").collect(&:strip)
		@products = Product.tagged_with(tags, :any => true)
		@products = @products.paginate(:page => params[:page], :per_page => 10) if params[:page].present?
		load_liked_product_ids
	end

	def popular
		@products = Product.order(likes: :desc)
		@products = @products.paginate(:page => params[:page], :per_page => 10) if params[:page].present?
		load_liked_product_ids
	end

	def show_offer
		@product = Product.includes(:user).find(params[:id])
		@conversations = @product.conversations.where.not(offer: nil).includes(:audience_one, :audience_two)
	end

	def followed
		@products = Product.where(user_id: current_api_user.relationships.pluck(:followed_id)).order(updated_at: :desc)
		@products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
		@products = @products.paginate(:page => params[:page], :per_page => params[:per_page]) if params[:per_page].present? or params[:page].present?
		load_liked_product_ids
	end

	def sold
		product = current_api_user.products.find(params[:id])
		receiver = User.find(params[:user_id])
		schedule = Schedule.create!
		message = "Please give #{product.user.full_name} your feedback about the product '#{product.name}'"
		extra = { product_id: product.id, schedule_id: schedule.id, notification_type: 0 }
		result = Notifier.schedule(UrbanAirshipPayload.schedule([ENV['FEEDBACK_REMIND_MINUTES'].to_i.minutes.from_now, [ENV['FEEDBACK_SECOND_REMIND_MINUTES'].to_i.minutes.from_now], message, { alias: receiver.alias_name }, extra))
		return render_failure(details: result['error']) unless result['ok']
		schedule.update!(operation_id: result['schedule_urls'].last)
		render_success
	end

	private

	def load_liked_product_ids
		@likes = current_api_user.likes.where(product_id: @products.map(&:id)).pluck(:product_id)
	end

	def product_params
		parameters = params.permit(:user_id, :name, :category_id, :description, :price, :sold_out, :buyer_id, :tag_list, :venue_id, :venue_name, :venue_long, :venue_lat)
		parameters[:images] = params[:images].map { |image| Image.create(:content => image) } if params[:images].present?

		return parameters
	end
end
