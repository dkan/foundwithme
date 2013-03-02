source 'http://rubygems.org'

ruby '1.9.3'

# Core
gem 'rails', '~> 3.2.11'
gem 'rake', '~> 10.0.3'
gem 'unicorn'

# Database
gem 'pg'
gem 'postgres_ext'

# Authentication and Authorization
gem 'devise'

# API
gem 'rest-client'

# Support
gem 'friendly_id', '~> 4.0.9'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'bootstrap-sass'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'taps', :require => false
end

group :development, :test do
  gem 'quiet_assets'
end
