class Api::V1::ChatsController < Api::BaseController

  def create
    return render_failure(details: "please provide params [to](recipient id) and [message]") if params[:to].blank? || params[:message].blank?
    product = Product.find_by(id: params[:product_id])
    return render_failure(details: "invalid product") unless product
    recipient = User.find_by(id: params[:to])
    return render_failure(details: "invalid recipient") unless recipient
    u = Urbanairship.push(:aliases => [recipient.alias_name], :aps => {:alert => "#{current_api_user.full_name} said: #{params[:message]}", :badge => 1})
    if u.success?
      chat = Chat.create(message: params[:message])
      product.products_chats.create(chat_id: chat.id, from: current_api_user.id, to: recipient.id)
      render_success(u)
    else
      render_failure(u)
    end

  end

  def index
    p = Product.find_by(id: params[:product_id])
    return render_failure(details: "invalid product") unless p
    if params[:to].present?
      @chats = p.products_chats.includes(:chat).where('"products_chats"."from" = ? OR "products_chats"."from" = ?', current_api_user.id, params[:to].to_i).where('"products_chats"."to" = ? OR "products_chats"."to" = ?', current_api_user.id, params[:to].to_i)
      @sender = false
    else
      @chats = p.products_chats.includes(:chat, :sender).where(to: current_api_user.id)
      @sender = true
    end
  end
end