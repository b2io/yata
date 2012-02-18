source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'jquery-rails'
gem 'rails-backbone'
gem 'simple_form', '~> 2.0.0.rc'
gem 'requirejs-rails'

group :development do
end

group :test do
  gem 'capybara'
  gem 'launchy', '~> 2.0.5'
  gem 'rspec-rails', '2.8.1'
  gem 'spork', '0.9.0.rc8'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'sqlite3', '1.3.5'
end

group :production do
  gem 'pg'
  gem 'thin'
end

group :assets do
  gem 'sass-rails', '3.2.3'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.0.3'
end

# Pull in the personal Gemfile if it exists.
eval File.read(File.expand_path("Gemfile.personal")) if File.exists?(File.expand_path("Gemfile.personal"))
