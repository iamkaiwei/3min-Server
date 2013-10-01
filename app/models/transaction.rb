class Transaction < ActiveRecord::Base
	belongs_to :product
	belongs_to :buyer, :class_name => "User"
	belongs_to :seller, :class_name => "User"

	validates_associated :product, :buyer, :seller
end
