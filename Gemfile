source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'jquery-rails'
gem 'rails-backbone'
gem 'spork', '0.9.0.rc8'
gem 'simple_form', '~> 2.0.0.rc'

group :development do
  gem 'rspec-rails', '2.8.1'
  gem 'sqlite3', '1.3.5'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'webrat', '0.7.1'	
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

eval File.read(File.expand_path("Gemfile.personal")) if File.exists?(File.expand_path("Gemfile.personal"))


