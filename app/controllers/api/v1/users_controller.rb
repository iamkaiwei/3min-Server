class Api::V1::UsersController < Api::BaseController
	def index
		@users = if params[:per_page].present? or params[:page].present?
						User.includes(:images).paginate(:page => params[:page], :per_page => params[:per_page])
					else
						User.all
					end
	end

	def show; end

	def update
	end

	def current; end

	def existence
	end

	def facebook
	end

private

	def user_params
	end
end
