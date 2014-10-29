class Product < ActiveRecord::Base
  acts_as_taggable

	belongs_to :user
	belongs_to :category
  belongs_to :buyer, :class_name => "User"
	has_many :transactions
	has_many :images, :as => :attachable, :dependent => :destroy
  has_many :conversations
  has_many :activities, as: :subject
  has_many :comments, dependent: :destroy
  has_many :feedbacks
  has_many :likes

	validates_associated :user, :category

  validates :likes_count, numericality: true, allow_nil: true

  scope :recently, ->(time){ where("(:time - created_at) >= (interval '1 day') AND (:time - created_at) <= (interval '3 days')", time: time) }

  after_create :increase_product_count
  after_destroy :decrease_product_count


  private

  def increase_product_count
    Counter.instance.increase_product_count
  end

  def decrease_product_count
    Counter.instance.decrease_product_count
  end
end
