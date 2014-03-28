class ConversationReply < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user

  scope :latest_message, ->(conversation_ids){ where("id IN (SELECT MAX(id)
                                                              from conversation_replies
                                                              where conversation_id IN (#{conversation_ids*','})
                                                              GROUP BY conversation_id )") }

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
end
