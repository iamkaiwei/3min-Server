class Api::V1::ConversationsController < Api::BaseController

  def create
    product = Product.find(params[:product_id])
    @recipient = User.find(params[:to])
    @conversation = Conversation.conversation_exist?(product.id, current_api_user.id, @recipient.id).first
    return @conversation = product.conversations.create(user_one: current_api_user.id, user_two: @recipient.id, offer: params[:offer]) unless @conversation
    u = Urbanairship.push(:aliases => [@recipient.alias_name],
                          :aps => { :alert => "#{current_api_user.full_name} offered: #{params[:offer]} for Product #{product.name}",
                                    :badge => 1, sound: "default", other: { product_id: @conversation.product_id,
                                                                            conversation_id: @conversation.id,
                                                                            channel_name: @conversation.channel_name } })

  end

  def index
    @conversations = current_api_user.activities(params[:page])
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

  def offer
    @conversation = Conversation.find(params[:id])
    return render_failure(message: "It's not your conversation") if @conversation.audience_one.id != current_api_user.id && @conversation.audience_two.id != current_api_user.id
    offer = params[:offer].to_f
    return render_failure(message: "Please input valid offer") if offer <= 0
    return render_failure unless @conversation.update_attribute(:offer, offer)
    render_success
  end

  def exist
    product = Product.find(params[:product_id])
    @recipient = User.find(params[:to])
    @conversation = Conversation.conversation_exist?(product.id, current_api_user.id, @recipient.id).first
    return render json: {} unless @conversation
  end
end