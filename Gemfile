source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "haml-rails", "~> 0.9"
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'twilio-ruby', '~> 4.11.1'
gem 'will_paginate', '~> 3.0.7'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootstrap_form'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'progressbar'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
gem 'active_model_serializers', '~> 0.10.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'doorkeeper'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'figaro'
gem 'factory_girl_rails'
gem 'faker'
gem 'responders'

gem 'geocoder'
gem 'gmaps4rails'

# To access Ruby variables in JS files
gem 'gon'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem "simplecov"
  gem "codeclimate-test-reporter", "~> 1.0.0"
  gem "selenium-webdriver", '2.53.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
