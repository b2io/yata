Rails.application.config.middleware.use OmniAuth::Builder do

  provider :twitter, "xKDrhyRODYhEHcTXyNlyGA", "baKuDMO1i1oc274s2ucVhvHoJRPnyMIh4ab8ctiH8"
  provider :google_oauth2, "56191514429.apps.googleusercontent.com", "BJ1WKwedh73JrltZpKB058Tx", { access_type: "online", approval_prompt: "", client_options: { ssl: { ca_file: "#{Rails.root}/config/ca-bundle.crt" } } }
  provider :facebook, "182061581901664", "140e0df7e84dc1608d7d89b0dda5871d", { client_options: { ssl: { ca_file: "#{Rails.root}/config/ca-bundle.crt" } } }
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']

end