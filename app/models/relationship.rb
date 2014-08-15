class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User
  belongs_to :followed, class_name: User

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :followed_id, uniqueness: { scope: :follower_id }

  has_many :activities, as: :subject

  after_save :create_activities

  def create_activities
    message = follower.full_name + ' followed you !'
    activities.create(content: message, user_id: followed_id, sender_id: follower_id)
  end
end
