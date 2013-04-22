module UsersHelper
  # Returns a Gravatar for a given user (Thanks to http://gravatar.com)
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=wavatar"
    image_tag(gravatar_url, alt: user.name, class:"gravatar")
  end

  def mate_progress(user)
    if user.mate_level == 1
      (user.mate_points / level_2_points.to_f) * 100
    elsif user.mate_level == 2
      (user.mate_points / level_3_points.to_f) * 100
    elsif user.mate_level == 3
      (user.mate_points / level_4_points.to_f) * 100
    elsif user.mate_level == 4
      (user.mate_points / level_5_points.to_f) * 100
    elsif user.mate_level == 5
      (user.mate_points / level_6_points.to_f) * 100
    end
  end

  def next_level(user)
    if user.mate_level == 1
      "Earn #{level_2_points - user.mate_points} more Mate Points and reach Mate Level 2!"
    elsif user.mate_level == 2
      "Earn #{level_3_points - user.mate_points} more Mate Points and reach Mate Level 3!"
    elsif user.mate_level == 3
      "Earn #{level_4_points - user.mate_points} more Mate Points and reach Mate Level 4!"
    elsif user.mate_level == 4
      "Earn #{level_5_points - user.mate_points} more Mate Points and reach Mate Level 5!"
    elsif user.mate_level == 5
      "Earn #{level_6_points - user.mate_points} more Mate Points and reach Mate Level 6!"
    end
  end

  def want_mate_points
    25
  end

  def help_mate_points
    50
  end

  def message_mate_points
    10
  end

  def invite_mate_points
    100
  end

  def level_2_points
    500
  end

  def level_3_points
    1000
  end

  def level_4_points
    2000
  end

  def level_5_points
    4000
  end

  def level_6_points
    7000
  end

end
