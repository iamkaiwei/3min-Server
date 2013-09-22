class Api::V1::CategoriesController < Api::BaseController
	def index
		respond_with Category.all
	end
end
