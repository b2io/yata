Rails.application.config.middleware.use OmniAuth::Builder do

  provider :twitter, "xKDrhyRODYhEHcTXyNlyGA", "baKuDMO1i1oc274s2ucVhvHoJRPnyMIh4ab8ctiH8"
  provider :google_oauth2, "56191514429.apps.googleusercontent.com", "BJ1WKwedh73JrltZpKB058Tx", { access_type: "online", approval_prompt: "", client_options: { ssl: { ca_file: "#{Rails.root}/config/ca-bundle.crt" } } }
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET']
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']

end