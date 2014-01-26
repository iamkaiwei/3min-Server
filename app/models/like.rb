class Like < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :user_id, presence: true
  validates :product_id, uniqueness: { scope: :user_id }

  scope :of_product, ->(product_id){ where(product_id: product_id) }
  scope :of_user, ->(user_id){ where(user_id: user_id) }

  before_destroy :decrease_product_likes

  def self.create_and_increase_product_likes args
    transaction do
      like = Like.create(args)
      return nil unless like.persisted?
      like.product.update(likes: like.product.likes.to_i + 1)
    end
  end

  def decrease_product_likes
    self.product.update(likes: self.product.likes.to_i - 1)
  end
end
