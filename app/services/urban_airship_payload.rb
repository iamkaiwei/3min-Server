class UrbanAirshipPayload

  def self.create message, audience = 'all', extra = {}
    extra = normalize_extra extra
    {
      audience: audience,
      device_types: ["ios", "android"],

      notification: {
        ios: {
          alert: message,
          badge: 1,
          sound: "default",
          extra: {
            other: extra
          }
        },
        android: {
          alert: message,
          extra: extra
        }
      }
    }
  end

  def self.schedule time, message, audience = 'all', extra = {}
    payload = {
      name: 'feedback',
      schedule: {
        scheduled_time: nil
      },
      push: create(message, audience, extra)
    }
    time.collect do |t|
      temp_payload = payload.dup
      temp_payload[:schedule][:scheduled_time] = format_time(t)
      temp_payload
    end
  end

  def self.format_time time
    time.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
  end

  def self.normalize_extra extra
    notification_type = Activity::TYPE[extra[:notification_type]]
    extra[:notification_type] = notification_type if notification_type
    extra
  end
end