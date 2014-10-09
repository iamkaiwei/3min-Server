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
end
