# Load the rails application
require File.expand_path('../application', __FILE__)

# Use the latest git tag to determine the semver of the application.
SEMVER = `git describe --always` unless defined? SEMVER

# Initialize the rails application
Yata::Application.initialize!