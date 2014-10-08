class Api::V1::ConversationRepliesController < Api::BaseController
  before_filter :load_and_authorize

  def create
    message = "#{current_api_user.full_name} said: #{params[:message].truncate(100, separator: ' ')}"
    extra = { product_id: @conversation.product_id, conversation_id: @conversation.id, notification_type: :chat }
    Notifier.push(UrbanAirshipPayload.create(message, { alias: @recipient.alias_name }, extra))

    @conversation.conversation_replies.create(user_id: current_api_user.id, reply: params[:message])
    render_success(u)
  end

  def bulk_create
    ConversationReply.bulk_create(params[:messages], current_api_user.id, @conversation.id)
    @conversation.touch
    render_success
  end

  private

  def load_and_authorize
    @conversation = Conversation.find(params[:conversation_id])
    @recipient = @conversation.recipient(current_api_user.id)
    return render_failure unless @recipient
  end
end