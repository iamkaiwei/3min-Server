class Api::V1::ProductsController < Api::BaseController
	def index
		@products = Product.order(id: :desc).includes(:images, :category, :user)
		@products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
		@products = @products.paginate(:page => params[:page], :per_page => params[:per_page]) if params[:per_page].present? or params[:page].present?
	end

	def show; end

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
		return render_failure(details: "You are not owner of this product") unless @product.user_id == current_api_user.id
		@product.destroy ? render_success : render_failure
	end

	private

	def product_params
		parameters = params.permit(:user_id, :name, :category_id, :description, :price, :sold_out)
		parameters[:images] = params[:images].map { |image| Image.create(:content => image) } if params[:images].present?

		return parameters
	end
end
