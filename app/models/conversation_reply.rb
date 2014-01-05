class ConversationReply < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user
end
