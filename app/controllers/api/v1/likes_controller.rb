class Api::V1::LikesController < Api::BaseController
  def index
    product = Product.find(params[:product_id])
    @users = product.likes.paginate(:page => params[:page], :per_page => params[:per_page]).includes(:user).collect { |like| like.user }
  end

  def create
    product = Product.find(params[:product_id])
    rs = Like.create_and_increase_product_likes(user_id: current_api_user.id, product_id: product.id)
    return render_failure unless rs

    message = "#{current_api_user.full_name} liked your product '#{product.name}'"
    extra = { product_id: product.id, notification_type: :like }
    Notifier.push(UrbanAirshipPayload.create(message, { alias: product.user.alias_name }, extra))
    render_success
  end

  def destroy
    product = Product.find(params[:product_id])
    like = Like.of_product(product.id).of_user(current_api_user.id).first
    return render_failure unless like
    like.destroy_and_decrease_product_likes ? render_success : render_failure
  end
end