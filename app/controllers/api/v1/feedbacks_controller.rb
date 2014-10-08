class Api::V1::FeedbacksController < Api::BaseController
  def index
    @feedbacks = current_api_user.feedbacks.includes(:sender).latest_order
                       .paginate(:page => params[:page], :per_page => params[:per_page])
  end

  def create
    product = Product.find(params[:product_id])
    feedback = product.feedbacks.new(feedback_params.merge(sender_id: current_api_user.id))
    return render_failure unless feedback.save
    schedule = Schedule.find_by(id: params[:schedule_id])
    schedule.remove if schedule
    render_success
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content, :status, :user_id)
  end
end