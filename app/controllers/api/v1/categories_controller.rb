class Api::V1::CategoriesController < Api::BaseController
	def index
		categories = Category.includes(:image)

		@categories = if params[:per_page].present? or params[:page].present?
						categories.paginate(:page => params[:page], :per_page => params[:per_page])
					else
						categories.all
					end
	end

	def show; end
end
