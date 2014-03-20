class Api::V1::ConversationsController < Api::BaseController
  def auth
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
    render :json => response
  end
end