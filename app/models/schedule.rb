class Schedule < ActiveRecord::Base
  scope :after_days, ->(number_of_days){ where("(NOW() - created_at) > interval '? days'", number_of_days) }

  def remove
    Notifier.destroy_schedule(operation_id)
    destroy
  end
end
