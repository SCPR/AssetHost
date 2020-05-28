source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# gem 'rails', '~> 5.0.2'
gem 'activerecord', '~> 5.0.2'
gem 'actionpack', '~> 5.0.2'
gem 'actionview', '~> 5.0.2'
gem 'activejob', '~> 5.0.2'
gem 'activesupport', '~> 5.0.2'
gem 'railties', '~> 5.0.2'
gem 'sprockets-rails', '~> 3.2.0'
gem 'mysql2', '>= 0.3.18', '< 0.5'

gem "photographic_memory", "0.0.3", github: "scpr/photographic_memory"

gem 'jquery-rails', '~> 4.2.2'
gem 'jbuilder', '~> 2.5'
gem 'jwt', '~> 0.1.4'
gem 'responders', '~> 2.3.0'

gem "paperclip", "5.2.1"
gem "searchkick", "4.0.2" #, '~> 2.5.0'
gem "cocaine", "0.5.8"
gem "redis-rails", "5.0.2"
gem "resque", "~> 1.27.2"
gem "resque-multi-job-forks", "~> 0.5.0"
gem 'sinatra', github: 'sinatra/sinatra', branch: 'master', require: false, ref: "34521720b6028c2fa696cf85109345a89f306c99"
# ^^ we need this for the resque interface to work, sadly
gem "mini_exiftool", "~> 2.8.0"
gem "faraday", "~> 0.8.7"
gem "faraday_middleware", "~> 0.9.0"
gem "google-api-client", "~> 0.6.3"
gem "brightcove-api", "~> 1.0.12"

gem "bootstrap-sass", "~> 2.3.1"
gem "simple_form", "~> 3.4.0"
gem "kaminari", "~> 1.2.1"

gem "aws-sdk", "~> 2"

gem 'asset_host_kpcc', github: 'scpr/asset_host_kpcc'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# New Relic APM
gem 'newrelic_rpm', '~> 4.0', '>= 4.0.0.332'

group :development, :test do
  ## These are grouped here because, theoretically,
  ## your assets should already be precompiled when
  ## deploying or running in production mode.
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.2'
  gem "eco", '~> 1.0.0'
  ## 
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring', '~> 2.0.1'
end

group :production do
  gem 'puma'
  gem 'dalli', '~> 2.7.6'
end

group :test do 
  gem "capybara", '~> 2.18.0'
  gem "factory_girl", '~> 4.8.0'
  gem "fakeweb", '~> 1.3.0'
  gem "launchy", '>= 2.1.1'
  gem "rspec", ">= 3.6.0.beta2"
  gem "rspec-rails", ">= 3.6.0.beta2"
  gem "rails-controller-testing"
  gem "rspec-its", "~> 1.2.0"
end

