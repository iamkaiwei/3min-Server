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

  private

  def increase_counter
    User.increment_counter("#{status}_count", user_id)
  end

  def descrease_counter
    User.increment_counter("#{status}_count", user_id)
  end
end
