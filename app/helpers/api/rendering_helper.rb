module Api::RenderingHelper
	def render_failure(args = {})
		render_result("failure", args)
	end

	def render_success(args = {})
		render_result("success", args)
	end

private

	def render_result(status, args)
		result = { :json => { :status => status, :timestamp => Time.now.to_i } }
		result[:json].merge!(args)
		result.merge!(args[:status_code]) if args[:status_code].present?

		render result
	end
end
