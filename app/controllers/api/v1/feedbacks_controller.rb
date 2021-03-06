class Api::V1::FeedbacksController < Api::BaseController
  def index
    user = User.find(params[:user_id])
    @feedbacks = user.feedbacks.includes(:sender, :product).latest_order
                       .paginate(:page => params[:page], :per_page => params[:per_page])
  end

  def create
    product = Product.find(params[:product_id])
    feedback = product.feedbacks.new(feedback_params.merge(sender_id: current_api_user.id))
    return render_failure unless feedback.save

    message = "#{current_api_user.full_name} gave you a feedback"
    extra = { product_id: product.id, notification_type: :feedback }
    Notifier.push(UrbanAirshipPayload.create(message, { alias: feedback.user.alias_name }, extra))

    schedule = Schedule.find_by(id: params[:schedule_id])
    schedule.remove if schedule
    render_success
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content, :status, :user_id)
  end
end