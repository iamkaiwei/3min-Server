class Like < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :user_id, presence: true
  validates :product_id, uniqueness: { scope: :user_id }

  scope :of_product, ->(product_id){ where(product_id: product_id) }
  scope :of_user, ->(user_id){ where(user_id: user_id) }

  after_create :create_activities

  def self.create_and_increase_product_likes args
    transaction do
      like = Like.create(args)
      return false unless like.persisted?
      like.product.update(likes_count: like.product.likes_count.to_i + 1)
    end
  end

  def destroy_and_decrease_product_likes
    return false unless destroy
    product.activities.where(user_id: product.user_id, sender_id: user_id).delete_all
    product.update(likes_count: product.likes_count.to_i - 1)
  end

  def create_activities
    product.activities.create(content: "#{user.full_name} liked your product '#{product.name}'",
                              user_id: product.user_id, sender_id: user_id, category: Activity::TYPE[:like])
  end
end
