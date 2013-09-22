class Api::V1::ProductsController < Api::BaseController
	def index
		@products = Product.paginate(:page => params[:page], :per_page => params[:per_page])
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			render_success(:product => @product.attributes)
		else
			render_failure(:details => @product.errors.full_messages.join("\n"))
		end
	end

	def update
		if @product.update_attributes(product_params)
			render_success(:product => @product.attributes)
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
		params.permit(:user_id, :name, :category_id, :description, :price, :sold_out)
	end
end
