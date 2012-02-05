module UsersHelper

  def provider_name(auth)
    case auth.provider
      when 'facebook'
        return 'Facebook'
      when 'google_oauth2'
        return 'Google'
      else
        return 'Unknown'
    end
  end

end
