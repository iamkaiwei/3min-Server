module Api::BaseHelper
	include Doorkeeper::Helpers::Filter

	def current_api_user
		@current_api_user ||= User.find_by_id(doorkeeper_token.resource_owner_id) if doorkeeper_token.present?

		return @current_api_user
	end
end
