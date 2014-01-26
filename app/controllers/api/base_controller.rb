class Api::BaseController < ApplicationController
	doorkeeper_for :all

	include Api::BaseHelper
	include Api::RenderingHelper
	include Api::ActiveRecordHelper

	protect_from_forgery with: :null_session

	respond_to :json

	before_filter(:only => [:show, :update]) { |controller| controller.fetch_object(params) }

	rescue_from ActiveRecord::RecordNotFound do |exception|
    render_failure(code: 404, message: exception.message)
  end

	def index
		klass = get_variable_name(params).classify.constantize

		if params.permit(:per_page).present? or params.permit(:page).present?
			respond_with klass.paginate(:per_page => params.permit(:per_page), :page => params.permit(:page))
		else
			respond_with klass.all
		end
	end

	def show
		variable_name = get_variable_name(params)

		respond_with instance_variable_get("@#{variable_name}".to_sym)
	end
end
