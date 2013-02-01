class NotificationsMailer < ActionMailer::Base

  default :from => "firstmate@beamate.com"
  default :to => "steinerhunter@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "Some feedback from  #{message.name}")
  end

end