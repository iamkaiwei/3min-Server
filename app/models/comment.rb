class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  scope :latest_order, ->{ order(created_at: :desc) }

  after_save :create_activities

  def create_activities
    product.activities.create(content: "#{user.full_name} commented on your product '#{product.name}'",
                              user_id: product.user_id, sender_id: user_id)
  end
end
