module Api::ActiveRecordHelper
	def fetch_object(params)
		variable = params[:controller].split("/").last.singularize
		klass = variable.classify.constantize

		instance_variable_set("@#{variable}".to_sym, klass.find_by_id(params[:id]))
	end
end
