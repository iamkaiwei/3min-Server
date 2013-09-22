module Api::RenderingHelper
	def render_failure(args)
		render_result("failure", %W(message details), args)
	end

	def render_success(args)
		render_result("success", %W(message data), args)
	end

private

	def render_result(status, merge_items, args)
		result = { :json => { :status => status, :timestamp => Time.now.to_i } }

		merge_items.each do |item|
			item_sym = item.to_sym
			result[:json][item_sym] = args[item_sym] if args[item_sym].present?
		end

		result.merge!(args[:status_code]) if args[:status_code].present?

		render result
	end
end
