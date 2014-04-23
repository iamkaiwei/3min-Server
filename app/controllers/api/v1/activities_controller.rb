class Api::V1::ActivitiesController < Api::BaseController
  def index
    @activities = User.find(4).activities.order(updated_at: :desc).paginate(page: params[:page])
  end
end