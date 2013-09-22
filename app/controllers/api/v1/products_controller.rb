class Api::V1::ProductsController < Api::BaseController
	def index
		@products = Product.all
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			render_success(:data => @product)
		else
			render_failure(:details => @product.errors.full_messages.join("\n"))
		end
	end

	def update
		@product = Product.find_by_id(params[:id])

		if @product.update_attributes
			render_success(:data => @product)
		else
			render_failure(:details => @product.errors.full_messages.join("\n"))
		end
	end

	def destroy
	end

	def details
	end

	def trending
	end

private

	def product_params
		params.require(:product).permit()
	end
end
