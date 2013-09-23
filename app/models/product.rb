class Product < ActiveRecord::Base
	belongs_to :user
	has_many :transactions
	has_many :images, :as => :attachable, :dependent => :destroy
end
