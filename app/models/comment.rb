class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  scope :latest_order, ->{ order(created_at: :desc) }
end
