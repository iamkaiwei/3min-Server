class ProductsChat < ActiveRecord::Base
  belongs_to :chat
  belongs_to :product
end
