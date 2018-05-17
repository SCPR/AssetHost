source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "activerecord", "~> 5.0.2"
gem "actionpack", "~> 5.0.2"
gem "actionview", "~> 5.0.2"
gem "activejob", "~> 5.0.2"
gem "activesupport", "~> 5.0.2"
gem "railties", "~> 5.0.2"
gem "sprockets-rails", "~> 3.2.0"
gem "sinatra", github: "sinatra/sinatra", branch: "master", require: false, ref: "34521720b6028c2fa696cf85109345a89f306c99"
# ^^ we need this for the resque interface to work, sadly
gem "ember-cli-rails"

gem "mysql2", ">= 0.3.18", "< 0.5"
gem "resque", "~> 1.27.2"
gem "searchkick", "~> 2.5.0"
gem "cocaine", "0.5.8"

gem "photographic_memory", path: "~/workspace/photographic_memory"
gem "paperclip", "5.2.1"
gem "mini_exiftool", "~> 2.8.0"
gem "faraday", "~> 0.9.2"
gem "faraday_middleware", "~> 0.9.0"
gem "google-api-client", "~> 0.21.1"
gem "brightcove-api", "~> 1.0.12"
gem "aws-sdk", "~> 2"

gem "knock"
gem "jbuilder", "~> 2.5"
gem "jwt", "~> 1.5"
gem "responders", "~> 2.3.0"
gem "kaminari", "~> 0.14.1"

# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"

group :development, :test do
  ## These are grouped here because, theoretically,
  ## your assets should already be precompiled when
  ## deploying or running in production mode.
  gem "sass-rails", "~> 5.0"
  gem "uglifier", ">= 1.3.0"
  gem "byebug", platform: :mri
  gem "dotenv-rails"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "spring", "~> 2.0.1"
end

group :production do
  gem "puma"
  gem "dalli", "~> 2.7.6"
end

group :test do 
  gem "capybara", "~> 2.18.0"
  gem "factory_girl", "~> 4.8.0"
  gem "fakeweb", "~> 1.3.0"
  gem "launchy", ">= 2.1.1"
  gem "rspec", ">= 3.6.0.beta2"
  gem "rspec-rails", ">= 3.6.0.beta2"
  gem "rails-controller-testing"
  gem "rspec-its", "~> 1.2.0"
end

