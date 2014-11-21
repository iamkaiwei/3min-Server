class Api::V1::ImagesController < Api::BaseController
  def create
    product = Product.find(params[:product_id])
    image = product.images.build(content: params[:content])
    image.save ? render_success : render_failure(messages: image.errors.full_messages )
  end
end