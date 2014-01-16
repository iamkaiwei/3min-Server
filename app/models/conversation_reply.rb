class ConversationReply < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user

  scope :latest_message, ->(conversation_ids){ where("id IN (SELECT MAX(id)
                                                              from conversation_replies
                                                              where conversation_id IN (#{conversation_ids*','}) GROUP BY conversation_id )") }

end
