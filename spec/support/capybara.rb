require 'capybara/rails'
require 'capybara/rspec'

# Setup capybara webkit as the driver for javascript-enabled tests.
Capybara.javascript_driver = :selenium