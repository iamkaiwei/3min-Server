class Api::V1::LikesController < Api::BaseController
  def create
    product = Product.find(params[:product_id])
    rs = Like.create_and_increase_product_likes(user_id: current_api_user.id, product_id: product.id)
    return render_failure unless rs
    render_success
  end

  def destroy
    product = Product.find(params[:product_id])
    like = Like.of_product(product.id).of_user(current_api_user.id).first
    return render_failure unless like
    like.destroy_and_decrease_product_likes ? render_success : render_failure
  end
end