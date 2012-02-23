# Load the rails application
require File.expand_path('../application', __FILE__)

# Use the latest tag on github to determine the semver of the application.
SEMVER = 'v0.3.0' unless defined? SEMVER

# Initialize the rails application
Yata::Application.initialize!