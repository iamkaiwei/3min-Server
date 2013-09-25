class Api::V1::ProductsController < Api::BaseController
	def index
		@products = if params[:per_page].present? or params[:page].present?
						Product.includes(:images).paginate(:page => params[:page], :per_page => params[:per_page])
					else
						Product.all
					end
	end

	def show; end

	def create
		@product = Product.new(product_params)

		if @product.save
			render_success(:product => render_json_rabl(@product, :show))
		else
			render_failure(:details => @product.errors.full_messages.join("\n"))
		end
	end

	def update
		if @product.update_attributes(product_params)
			render_success(:product => render_json_rabl(@product, :show))
		else
			render_failure(:details => @product.errors.full_messages.join("\n"))
		end
	end

	def destroy
		if @product.destroy
			render_success
		else
			render_failure
		end
	end

private

	def product_params
		parameters = params.permit(:user_id, :name, :category_id, :description, :price, :sold_out)
		parameters[:images] = params[:images].map { |image| Image.create(:content => image) } if params[:images].present?
		
		return parameters
	end
end
