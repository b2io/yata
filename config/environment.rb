# Load the rails application
require File.expand_path('../application', __FILE__)

# Use the latest git tag to determine the semver of the application.
SEMVER = `git describe --always`.to_s.match(/(^[v\d\.]+)/i) unless defined? SEMVER

# Initialize the rails application
Yata::Application.initialize!