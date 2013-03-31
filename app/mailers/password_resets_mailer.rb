class PasswordResetsMailer < ActionMailer::Base
  default :from => "firstmate@beamate.com"

  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Reset your BeAMate password")
  end
end
