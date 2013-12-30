class Api::V1::CategoriesController < Api::BaseController
	def index
		@categories = Category.includes(:image)
		@categories = @categories.paginate(:page => params[:page], :per_page => params[:per_page]) if params[:per_page].present? or params[:page].present?
	end

	def show; end
end
