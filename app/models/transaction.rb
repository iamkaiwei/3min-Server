class Transaction < ActiveRecord::Base
	belongs_to :product
	belongs_to :buyer, :class => User
	belongs_to :seller, :class => User
end
