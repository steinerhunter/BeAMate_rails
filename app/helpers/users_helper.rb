module UsersHelper
  # Returns a Gravatar for a given user (Thanks to http://gravatar.com)
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=wavatar"
    image_tag(gravatar_url, alt: user.name, class:"gravatar")
  end

  def mate_progress(user)
    if user.mate_level == 1
      (user.mate_points / BeAMateRails::Application::LEVEL_2_POINTS.to_f) * 100
    elsif user.mate_level == 2
      (user.mate_points / BeAMateRails::Application::LEVEL_3_POINTS.to_f) * 100
    elsif user.mate_level == 3
      (user.mate_points / BeAMateRails::Application::LEVEL_4_POINTS.to_f) * 100
    elsif user.mate_level == 4
      (user.mate_points / BeAMateRails::Application::LEVEL_5_POINTS.to_f) * 100
    elsif user.mate_level == 5
      (user.mate_points / BeAMateRails::Application::LEVEL_6_POINTS.to_f) * 100
    end
  end

  def next_level(user)
    if user.mate_level == 1
      "Earn #{BeAMateRails::Application::LEVEL_2_POINTS - user.mate_points} more Mate Points and reach Mate Level 2!"
    elsif user.mate_level == 2
      "Earn #{BeAMateRails::Application::LEVEL_3_POINTS - user.mate_points} more Mate Points and reach Mate Level 3!"
    elsif user.mate_level == 3
      "Earn #{BeAMateRails::Application::LEVEL_4_POINTS - user.mate_points} more Mate Points and reach Mate Level 4!"
    elsif user.mate_level == 4
      "Earn #{BeAMateRails::Application::LEVEL_5_POINTS - user.mate_points} more Mate Points and reach Mate Level 5!"
    elsif user.mate_level == 5
      "Earn #{BeAMateRails::Application::LEVEL_6_POINTS - user.mate_points} more Mate Points and reach Mate Level 6!"
    end
  end

end
