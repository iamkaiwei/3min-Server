class ProductsChat < ActiveRecord::Base
  belongs_to :chat
  belongs_to :product
  belongs_to :receiver, class_name: "User", foreign_key: "to"
  belongs_to :sender, class_name: "User", foreign_key: "from"
end
