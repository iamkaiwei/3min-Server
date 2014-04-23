class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :user
  belongs_to :sender, class_name: User
end
