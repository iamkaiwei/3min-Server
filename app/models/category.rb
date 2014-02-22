class Category < ActiveRecord::Base
  TYPES = %w(taggable display)
	has_many :products
	has_one :image, :as => :attachable, :dependent => :destroy

	accepts_nested_attributes_for :image

  TYPES.each do |type|
    scope type, ->{ where(specific_type: type) }
  end
end
