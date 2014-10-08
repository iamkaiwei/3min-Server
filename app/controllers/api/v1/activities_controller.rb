class Api::V1::ActivitiesController < Api::BaseController
  def index
    @activities = current_api_user.activities.includes(:subject).order(updated_at: :desc).paginate(page: params[:page])
  end
end