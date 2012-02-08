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

  def confirm_delete_auth_message(auth)
    "Are you sure you want to unlink this " + provider_name(auth) + " (" + auth.email + ") account?"
  end

end
