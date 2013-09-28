class Doorkeeper::CustomTokensController < Doorkeeper::TokensController
	include Api::RenderingHelper

	def create
		super

		response = JSON.parse(self.response_body.first)
		access_token = Doorkeeper::AccessToken.find_by_token(response["access_token"])
		user = User.find_by_id(access_token.resource_owner_id)
		response["user"] = render_json_rabl(user, :show)

		self.response_body = [response.to_json]
	end
end
