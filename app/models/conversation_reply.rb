class ConversationReply < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user
  validates :reply, length: { minimum: 3 }

  scope :latest_message, ->(conversation_ids){ where("id IN (SELECT MAX(id)
                                                              from conversation_replies
                                                              where conversation_id IN (#{conversation_ids*','})
                                                              GROUP BY conversation_id )") }
  after_save :create_activities

  def self.bulk_create messages, user_id, conversation_id
    inserts = []
    messages.each do |message|
      reply = sanitize(message[:reply])
      created_at = sanitize(Time.at(message[:created_at].to_i))
      inserts.push("(#{user_id}, #{reply}, #{created_at}, #{conversation_id})")
    end

    sql = "INSERT INTO conversation_replies (user_id, reply, created_at, conversation_id) VALUES #{inserts.join(", ")}"
    connection.execute(sql)
  end

  def create_activities
    receiver_id = [conversation.user_one, conversation.user_two].reject{ |id| id == user_id }.first
    content = user.full_name.to_s + " said: " + reply.truncate(50, separator: ' ')
    activity = Activity.where(subject_id: conversation.id, user_id: receiver_id).first
    return activity.update(content: content) if activity
    conversation.activities.create(user_id: receiver_id, content: content, sender_id: user_id, category: Activity::TYPE[:chat])
  end
end
