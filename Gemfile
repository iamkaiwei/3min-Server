source "https://rubygems.org"

ruby "2.0.0"
# gem "rails", :github => "rails/rails", :branch => "4-0-stable"
gem 'rails', '~> 4.0.0'

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
gem 'sass-rails', '4.0.2'
gem "turbolinks"
gem "uglifier"
gem 'bootstrap-sass'

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

gem 'activeadmin', github: 'gregbell/active_admin'

gem 'spring'

# Database environment gems
group :db do
	gem "faker"
end

# Development and test environment gems
group :development, :test do
	gem "better_errors"
	gem "binding_of_caller"
	gem "guard-rspec"
	gem "pry"
	gem "rspec-rails", '~> 2.14.2'
	gem 'debugger'
  gem 'spring-commands-rspec'
	gem 'rspec_wiki', git: 'https://github.com/nlds90/rspec_wiki.git'
end

group :test do
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'ffaker', '~> 1.20.0'
  gem 'shoulda-matchers', require: false
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
