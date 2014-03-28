class Api::V1::ConversationRepliesController < Api::BaseController
  before_filter :load_and_authorize

  def create
    u = Urbanairship.push(:aliases => [@recipient.alias_name], :aps => { :alert => "#{current_api_user.full_name} said: #{params[:message].truncate(100, :separator => ' ')}", :badge => 1, sound: "default", other: { product_id: @conversation.product_id, conversation_id: @conversation.id } })
    return render_failure(u) unless u.success?
    @conversation.conversation_replies.create(user_id: current_api_user.id, reply: params[:message])
    render_success(u)
  end

  def bulk_create
    params[:messages].each do |message|
      @conversation.conversation_replies.create(user_id: current_api_user.id, reply: message.reply,
                                               created_at: Time.at(params[:created_at].to_i))
    end
  end

  private

  def load_and_authorize
    @conversation = Conversation.find(params[:conversation_id])
    @recipient = @conversation.recipient(current_api_user.id)
    return render_failure unless @recipient
  end
end