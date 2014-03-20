class Api::V1::PushersController < Api::BaseController
  def auth
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
    render :json => response
  end
end