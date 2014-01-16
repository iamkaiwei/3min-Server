class Api::V1::ConversationRepliesController < Api::BaseController
  def create
    conversation = Conversation.find(params[:conversation_id])
    recipient = conversation.audience_one.id == current_api_user.id ? conversation.audience_two : conversation.audience_one
    u = Urbanairship.push(:aliases => [recipient.alias_name], :aps => { :alert => "#{current_api_user.full_name} said: #{params[:message].truncate(100, :separator => ' ')}", :badge => 1, sound: "default", other: { product_id: conversation.product_id, conversation_id: conversation.id } })
    return render_failure(u) unless u.success?
    conversation.conversation_replies.create(user_id: current_api_user.id, reply: params[:message])
    render_success(u)
  end
end