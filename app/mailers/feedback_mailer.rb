class FeedbackMailer < ActionMailer::Base
  default :from => "firstmate@beamate.com"

  def new_feedback(feedback)
    @feedback = feedback
    mail(:to => "steinerhunter@gmail.com", :subject => "Some feedback from  #{feedback.name}")
  end
end