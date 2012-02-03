module ApplicationHelper

  def full_title(page_title)
    base_title = "YATA"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def get_avatar_url(user = current_user, options = { size: 24 })
    if user.avatar_url.present?
      user.avatar_url
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{options[:size]}"
    end
  end
end
