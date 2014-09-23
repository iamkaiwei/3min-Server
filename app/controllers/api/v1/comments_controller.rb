class Api::V1::CommentsController < Api::BaseController
  def index
    product = Product.find(params[:product_id])
    @comments = product.comments.includes(:user).latest_order
                       .paginate(:page => params[:page], :per_page => params[:per_page])
  end

  def create
    product = Product.find(params[:product_id])
    comment = product.comments.new(comment_params.merge(user_id: current_api_user.id))
    comment.save ? render_success : render_failure
  end

  def update
    @comment = current_api_user.comments.find(params[:id])
    @comment.update(comment_params) ? render_success : render_failure
  end

  def destroy
    @comment = current_api_user.comments.find(params[:id])
    @comment.destroy ? render_success : render_failure
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end