class Category < ActiveRecord::Base
	attr_accessible :image_attributes, :name, :description

	has_many :products
	has_one :image, :as => :attachable, :dependent => :destroy

	accepts_nested_attributes_for :image
end
