source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'jquery-rails'
gem 'backbone-on-rails'
gem 'simple_form', '~> 2.0.0.rc'
gem 'rabl', '~> 0.5.5.h'
gem 'gon'
gem 'acts_as_list'

group :development do
end

group :test do
  gem 'capybara'
  gem 'launchy', '~> 2.0.5'
  gem 'rspec-rails'
  gem 'spork'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'thin'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

# Pull in the personal Gemfile if it exists.
eval File.read(File.expand_path("Gemfile.personal")) if File.exists?(File.expand_path("Gemfile.personal"))
