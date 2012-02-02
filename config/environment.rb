# Load the rails application
require File.expand_path('../application', __FILE__)

# Use the latest git tag to determine the semver of the application.
SEMVER = "v0.1.1"

# Initialize the rails application
Yata::Application.initialize!