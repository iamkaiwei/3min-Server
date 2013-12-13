module Doorkeeper
	class CustomTokensController < Doorkeeper::TokensController

		def create
			response = strategy.authorize
	    self.headers.merge! response.headers
	    rsp_body = response.body
	    rsp_body["user"] = User.find(response.token.resource_owner_id) if response.status == :ok
	    self.response_body = rsp_body.to_json
	    self.status        = response.status
	  rescue Errors::DoorkeeperError => e
	    handle_token_exception e
		end
	end
end
