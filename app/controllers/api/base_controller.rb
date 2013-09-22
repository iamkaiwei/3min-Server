class Api::BaseController < ApplicationController
	include Api::RenderingHelper
	include Api::ActiveRecordHelper

	protect_from_forgery with: :null_session

	respond_to :json

	before_filter(:only => [:show, :update, :destroy]) { |controller| controller.fetch_object(params) }
	before_filter :authenticate_user_with_token!, :only => [:create, :update, :destroy]
	# before_filter :authenticate_user!

	def index
		klass = get_variable_name(params).classify.constantize

		respond_with klass.all
	end

	def show
		variable_name = get_variable_name(params)

		respond_with instance_variable_get("@#{variable_name}".to_sym)
	end

protected

	def authenticate_user_with_token!
		return unless params[:fb_id].present?
		
		user = User.find_by_facebook_id(params[:fb_id])

		return unless user.present?

		sign_in(user, :store => false) if Devise.secure_compare(user.authentication_token, params[:auth_token])
	end
end
