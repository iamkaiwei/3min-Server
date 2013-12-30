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

	def device_token
		rs = Urbanairship.register_device(params[:token], :alias => current_api_user.alias_name)
		render json: rs
	end

private

	def user_params
	end
end
