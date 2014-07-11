class Api::V1::RelationshipsController < Api::BaseController
  def create
    @recipient = User.find(params[:user_id])
    relationship = current_api_user.relationships.new(followed_id: params[:user_id])
    if relationship.save
      message = "#{current_api_user.full_name} followed you !"
      Notifier.push(UrbanAirshipPayload.create(message, { alias: @recipient.alias_name }, { user_id: current_api_user.id }))
      render json: ''
    else
      render_failure message: 'Already followed'
    end
  end

  def unfollow
    relationship = current_api_user.relationships.find_by!(followed_id: params[:user_id])
    if relationship.destroy
      render json: ''
    else
      render_failure
    end
  end
end