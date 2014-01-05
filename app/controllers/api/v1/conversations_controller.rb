class Api::V1::ConversationsController < Api::BaseController

  def create
    product = Product.find(params[:product_id])
    recipient = User.find(params[:to])
    conversation = Conversation.conversation_exist?(product.id, current_api_user.id, recipient.id).first || product.conversations.create(user_one: current_api_user.id, user_two: recipient.id )
    u = Urbanairship.push(:aliases => [recipient.alias_name], :aps => { :alert => "#{current_api_user.full_name} said: #{params[:message].truncate(100, :separator => ' ')}", :badge => 1, sound: "default", other: { product_id: product.id, conversation_id: conversation.id } })
    return render_failure(u) unless u.success?
    conversation.conversation_replies.create(user_id: current_api_user.id, reply: params[:message])
    render_success(u)
  end

  def index
    @conversations = Conversation.of_you(current_api_user.id).order(updated_at: :desc).paginate(:page => params[:page]).includes(:audience_one, :audience_two)
  end

  def show
    @conversation_replies = @conversation.conversation_replies.order(created_at: :desc)
    if params[:larger]
      @conversation_replies = @conversation_replies.where("id > ?", params[:larger])
    else
      @conversation_replies = @conversation_replies.paginate(:page => params[:page])
      @conversation_replies = @conversation_replies.where("id <= ?", params[:smaller]) if params[:smaller]
    end
  end
end