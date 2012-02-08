require 'omniauth'

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:google_oauth2, {
    uid: "01234",
    info: {
        name: "Example User",
        email: "user@example.com"
    }
})
OmniAuth.config.add_mock(:facebook, {
    uid: "56789",
    info: {
        name: "Example User",
        email: "user@example.com"
    }
})