class Product < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	has_many :transactions
	has_many :images, :as => :attachable, :dependent => :destroy
  has_many :conversations

	validates_associated :user, :category
end
