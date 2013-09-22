module Api::ActiveRecordHelper
	include ApplicationHelper

	def fetch_object(params)
		variable_name = get_variable_name(params)
		klass = variable_name.classify.constantize

		raise ActiveRecord::RecordNotFound unless klass.exists?(:id => params[:id])

		instance_variable_set("@#{variable_name}".to_sym, klass.find_by_id(params[:id]))
	end
end
