class NotificationsMailer < ActionMailer::Base

  default :from => "firstmate@beamate.com"
  default :to => "steinerhunter@gmail.com"

  def new_feedback(feedback)
    @feedback = feedback
    mail(:subject => "Some feedback from  #{feedback.name}")
  end

end