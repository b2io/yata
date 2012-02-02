source 'https://rubygems.org'

gem 'rails'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'jquery-rails'
gem 'rails-backbone'

group :development do
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

eval File.read(File.expand_path("Gemfile.personal")) if File.exists?(File.expand_path("Gemfile.personal"))


