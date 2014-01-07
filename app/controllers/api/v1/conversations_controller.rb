class Api::V1::ConversationsController < Api::BaseController

  def create
    product = Product.find(params[:product_id])
    @recipient = User.find(params[:to])
    @conversation = Conversation.conversation_exist?(product.id, current_api_user.id, @recipient.id).first
    return @conversation = product.conversations.create(user_one: current_api_user.id, user_two: @recipient.id ) unless @conversation
    @conversation_replies = @conversation.conversation_replies.order(created_at: :desc).paginate(:page => 1)
  end

  def index
    @conversations = Conversation.of_you(current_api_user.id).order(updated_at: :desc).paginate(:page => params[:page]).includes(:audience_one, :audience_two)
  end

  def show
    return render_failure(message: "It's not your conversation") if @conversation.audience_one.id != current_api_user.id && @conversation.audience_two.id != current_api_user.id
    @conversation_replies = @conversation.conversation_replies.order(created_at: :desc)
    if params[:larger]
      @conversation_replies = @conversation_replies.where("id > ?", params[:larger])
    else
      @conversation_replies = @conversation_replies.paginate(:page => params[:page])
      @conversation_replies = @conversation_replies.where("id <= ?", params[:smaller]) if params[:smaller]
    end
  end
end