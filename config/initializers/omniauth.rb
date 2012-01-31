Rails.application.config.middleware.use OmniAuth::Builder do

  # If we're in the development environment, don't verify peer SSL certificates because Windows fails hard at it.
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?

  provider :twitter, ENV['YATA_TWITTER_CONSUMER_KEY'], ENV['YATA_TWITTER_CONSUMER_SECRET']
  provider :google_oauth2, ENV['YATA_GOOGLE_CLIENT_ID'], ENV['YATA_GOOGLE_CLIENT_SECRET'], { access_type: "online", approval_prompt: "" }
  provider :facebook, ENV['YATA_FACEBOOK_APP_ID'], ENV['YATA_FACEBOOK_APP_SECRET']
  provider :github, ENV['YATA_GITHUB_CLIENT_ID'], ENV['YATA_GITHUB_SECRET']

end