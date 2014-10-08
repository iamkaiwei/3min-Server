class Notifier

  def self.push notify_hash
    resource = RestClient::Resource.new('https://go.urbanairship.com/api/push', ENV['UA_APPLICATION_KEY'], ENV['UA_MASTER_SECRET'])
    resource.post(notify_hash.to_json, content_type: :json, accept: 'application/vnd.urbanairship+json; version=3;') do |response|
      response
    end
  end

  def self.schedule notify_hash
    resource = RestClient::Resource.new('https://go.urbanairship.com/api/schedules', ENV['UA_APPLICATION_KEY'], ENV['UA_MASTER_SECRET'])
    resource.post(notify_hash.to_json, content_type: :json, accept: 'application/vnd.urbanairship+json; version=3;') do |response|
      JSON.parse response
    end
  end

  def self.destroy_schedule url
    resource = RestClient::Resource.new(url, ENV['UA_APPLICATION_KEY'], ENV['UA_MASTER_SECRET'])
    resource.delete(content_type: :json, accept: 'application/vnd.urbanairship+json; version=3;') do |response|
      response
    end
  end
end