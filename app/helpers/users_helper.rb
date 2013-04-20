module UsersHelper
  # Returns a Gravatar for a given user (Thanks to http://gravatar.com)
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=wavatar"
    image_tag(gravatar_url, alt: user.name, class:"gravatar")
  end

  def want_mate_points
    "25"
  end

  def help_mate_points
    "50"
  end

  def message_mate_points
    "10"
  end

  def invite_mate_points
    "100"
  end

end
