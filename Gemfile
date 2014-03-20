source "https://rubygems.org"

ruby "2.0.0"
# gem "rails", :github => "rails/rails", :branch => "4-0-stable"
gem 'rails', '~> 4.0.0'



# Admin gems
gem "activeadmin", :github => "gregbell/active_admin"

# Amazon AWS gems
gem "aws-sdk"

# API gems
gem "rabl"
gem "oj"
gem "rest-client"

# Attachment gems
gem "paperclip"

# Database gems
gem "pg"

# Front-end gems
gem "coffee-rails"
gem "jbuilder"
gem "jquery-rails"
gem "sass-rails"
gem "turbolinks"
gem "uglifier"

# Output arrangement gems
gem "will_paginate"

# Security gems
gem "bcrypt-ruby"
gem "devise"
gem "doorkeeper"

# Server gems
gem "puma"
gem "figaro"

gem "urbanairship"
gem 'acts-as-taggable-on'

gem 'pusher'

# Database environment gems
group :db do
	gem "faker"
end

# Development and test environment gems
group :development, :test do
	gem "better_errors"
	gem "binding_of_caller"
	gem "factory_girl_rails"
	gem "guard-livereload"
	gem "guard-rspec"
	gem "pry"
	gem "rspec-rails"
	gem 'debugger'
end

# Documentation environment gems
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc", :require => false
end

# Heroku environment gems
group :staging, :production do
	gem "rails_12factor"
end
