Paperclip.interpolates(:amazon_s3_url) do |att, style|
	"https://s3-ap-southeast-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
end

