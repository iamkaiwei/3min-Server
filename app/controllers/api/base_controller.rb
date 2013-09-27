class Api::BaseController < ApplicationController
	doorkeeper_for :all

	include Api::RenderingHelper
	include Api::ActiveRecordHelper

	protect_from_forgery with: :null_session

	respond_to :json

	before_filter(:only => [:show, :update, :destroy]) { |controller| controller.fetch_object(params) }

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

protected

	def render_json_rabl(variable, file)
		JSON.parse(Rabl::Renderer.json(variable, "api/v1/#{variable.class.to_s.downcase.pluralize}/#{file}", :view_path => "app/views"))
	end
end
