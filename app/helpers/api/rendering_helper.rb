module Api::RenderingHelper
	def render_failure(args = {})
		args[:code] ||= 400
		render_result("failure", args)
	end

	def render_success(args = {})
		args[:code] ||= 200
		render_result("success", args)
	end

	def render_json_rabl(variable, file)
		JSON.parse(Rabl::Renderer.json(variable, "api/v1/#{variable.class.to_s.downcase.pluralize}/#{file}", :view_path => "app/views"))
	end

private

	def render_result(status, args)
		result = { :json => { :status => status, :timestamp => Time.now.to_i }, status: args[:code] }
		args.delete(:code)
		result[:json].merge!(args)

		render result
	end
end
