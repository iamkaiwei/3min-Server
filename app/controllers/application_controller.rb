class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def after_sign_in_path_for(resource)
		return admin_root_path if resource.admin?

		root_path
	end

	def authenticate_admin_user!
		redirect_to new_user_session_url unless current_admin_user.present?

		authenticate_user!
	end

	def current_admin_user
		return nil unless user_signed_in? && current_user.admin?

		current_user
	end
end
