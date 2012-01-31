Rails.application.config.middleware.use OmniAuth::Builder do

  # If we're in the development environment, don't verify peer SSL certificates because Windows fails hard at it.
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?

  provider :twitter, "xKDrhyRODYhEHcTXyNlyGA", "baKuDMO1i1oc274s2ucVhvHoJRPnyMIh4ab8ctiH8"
  provider :google_oauth2, "56191514429.apps.googleusercontent.com", "BJ1WKwedh73JrltZpKB058Tx", { access_type: "online", approval_prompt: "" }
  provider :facebook, "182061581901664", "140e0df7e84dc1608d7d89b0dda5871d"
  provider :github, "287061ef6fff86d4ad86", "9855cec23f0631d465423edef4376075521cd1c8"

end