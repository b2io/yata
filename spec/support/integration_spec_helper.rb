module IntegrationSpecHelper
  def login_with_omniauth(service = :google_oauth2)
    visit "/auth/#{service}"
  end

  def logout()
    visit logout_path
  end
end