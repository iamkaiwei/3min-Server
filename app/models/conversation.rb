class Conversation < ActiveRecord::Base
  attr_writer :latest_message
  has_many :conversation_replies, dependent: :destroy
  belongs_to :product
  belongs_to :audience_one, :class_name => "User", :foreign_key => "user_one"
  belongs_to :audience_two, :class_name => "User", :foreign_key => "user_two"

  scope :conversation_exist?, ->(product_id, user_one_id, user_two_id){ where(product_id: product_id).where("(user_one = :one AND user_two = :two) OR (user_one = :two AND user_two = :one)", one: user_one_id, two: user_two_id) }
  scope :of_you, ->(user_id){ where("user_one = :me OR user_two = :me", me: user_id) }

  def latest_message
    @latest_message || "Offered #{self.offer}"
  end

  def channel_name
    "private-channel-#{audience_one.id}-#{audience_two.id}"
  end
end
