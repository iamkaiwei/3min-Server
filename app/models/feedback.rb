class Feedback < ActiveRecord::Base

  STATUS = %w(negative positive normal)

  belongs_to :user
  belongs_to :sender, class_name: User
  belongs_to :product

  validates :user_id, presence: true
  validates :status, inclusion: { in: STATUS }
  validates :content, presence: true

  after_create :increase_counter
  after_destroy :descrease_counter
  after_create :create_activities

  private

  def increase_counter
    User.increment_counter("#{status}_count", user_id)
  end

  def descrease_counter
    User.increment_counter("#{status}_count", user_id)
  end

  def create_activities
    content = "#{sender.full_name} gave you a feedback"
    product.activities.create(user_id: user_id, sender_id: sender_id, content: content, category: Activity::TYPE[:feedback])
  end
end
