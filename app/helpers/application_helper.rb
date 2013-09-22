module ApplicationHelper
	def get_variable_name(params)
		params[:controller].split("/").last.singularize
	end
end
