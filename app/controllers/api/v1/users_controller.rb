class Api::V1::UsersController < Api::BaseController
	def index
		@users = User.includes(:image)
		@users = @users.paginate(:page => params[:page], :per_page => params[:per_page]) if params[:per_page].present? or params[:page].present?
	end

	def show; end

	def update
	end

	def current; end

	def existence
	end

	def facebook
	end

	def products
		user = User.find(params[:id])
		@products = user.products.order(id: :desc).includes(:images, :category)
	  if params[:per_page].present? or params[:page].present?
			@products = @products.paginate(:page => params[:page], :per_page => params[:per_page])
		end
		load_liked_product_ids
	end

	def followers
		@users = User.find(params[:id]).followers.paginate(:page => params[:page], :per_page => params[:per_page]).to_a
		@followed_users = current_api_user.relationships.where(followed_id: @users.map(&:id)).pluck(:followed_id)
	end

	def followings
		@users = User.find(params[:id]).followed_users.paginate(:page => params[:page], :per_page => params[:per_page]).to_a
		@followed_users = current_api_user.relationships.where(followed_id: @users.map(&:id)).pluck(:followed_id)
	end

private
	def load_liked_product_ids
		@likes = current_api_user.likes.where(product_id: @products.map(&:id)).pluck(:product_id)
	end

	def user_params
	end
end
