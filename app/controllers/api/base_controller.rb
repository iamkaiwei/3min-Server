class Api::BaseController < ApplicationController
	include Api::RenderingHelper
	include Api::ActiveRecordHelper

	respond_to :json

	before_filter(:only => [:show, :update, :destroy]) { |controller| controller.fetch_object(params) }
	before_filter :authenticate_user!, :only => [:create, :update, :destroy]

	def show
		variable = params[:controller].split("/").last.singularize

		respond_with instance_variable_get("@#{variable}".to_sym)
	end
end
