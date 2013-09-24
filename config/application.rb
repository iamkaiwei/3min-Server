require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module ThreeminsServer
	class Application < Rails::Application
		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.

		# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
		# Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
		# config.time_zone = 'Central Time (US & Canada)'

		# The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
		# config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
		# config.i18n.default_locale = :de

		# Default pagination size
		WillPaginate.per_page = 10

		# Paperclip settings for Amazon S3 storage
		config.paperclip_defaults = {
			:storage => :s3,
			:s3_host_name => "s3-ap-southeast-1.amazonaws.com",
			:s3_protocol => "https",
			:s3_credentials => {
				:bucket => ENV["AMAZON_S3_BUCKET"],
				:access_key_id => ENV["AWS_ACCESS_KEY_ID"],
				:secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
			},
			:url => ":amazon_s3_url",
			:path => ":class/:attachment/:style/:basename_:id.:extension"
		}
	end
end
