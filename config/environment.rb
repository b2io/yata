# Load the rails application
require File.expand_path('../application', __FILE__)

# Use the latest tag on github to determine the semver of the application.
SEMVER = `curl http://github.com/api/v2/json/repos/show/mewdriller/yata/tags`.to_s.scan(/(?<=")([v\d\.]+)(?>")/im).sort.last.last unless defined? SEMVER


# Initialize the rails application
Yata::Application.initialize!