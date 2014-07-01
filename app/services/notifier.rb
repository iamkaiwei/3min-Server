class Notifier

  def self.push notify_hash
    resource = RestClient::Resource.new('https://go.urbanairship.com/api/push', ENV['UA_APPLICATION_KEY'], ENV['UA_MASTER_SECRET'])
    resource.post(notify_hash.to_json, content_type: :json, accept: 'application/vnd.urbanairship+json; version=3;') do |response|
      response
    end
  end
end