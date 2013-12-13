require "rest_client"
require "date"

module FacebookHelper
	def self.me(access_token, *fields)
		begin
			response = RestClient.get("https://graph.facebook.com/me?access_token=#{access_token}&fields=#{fields.join(",")}")
			json = JSON.parse(response)

			json["birthday"] = Date.strptime(json["birthday"], "%m/%d/%Y") if json["birthday"].present?
			# if json["picture"].present?
			# 	url = json["picture"]["data"]["url"]
			# 	extension = File.extname(url)
			# 	file_name = File.basename(url, extension)

			# 	file = Tempfile.new([file_name, extension])
			# 	file.binmode

			# 	open(url) do |data|
			# 		file.write(data.read)
			# 	end

			# 	file.rewind

			# 	json["picture"] = file
			# end

			json.symbolize_keys
		rescue => e
			puts "FACEBOOK_HELPER: #{e.inspect}"
			{}
		end
	end
end
