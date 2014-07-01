class UrbanAirshipPayload
  def self.create message, audience = 'all', extra = {}
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
end