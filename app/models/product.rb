class Product < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	has_many :transactions
	has_many :images, :as => :attachable, :dependent => :destroy

	validates_associated :user, :category
end
