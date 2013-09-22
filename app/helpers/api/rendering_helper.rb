module Api::RenderingHelper
	def render_failure(*args)
		render_result("failure", %W(message details), args)
	end

	def render_success(*args)
		render_result("success", %W(message data), args)
	end

private

	def render_result(status, merge_items, *args)
		result = { :json => { :status => status, :timestamp => Time.now.to_i } }

		merge_items.each do |item|
			result[:json].merge!(args[item.to_sym]) if args[item.to_sym].present?
		end

		result.merge!(args[:status_code]) if args[:status_code]

		respond_with result
	end
end
