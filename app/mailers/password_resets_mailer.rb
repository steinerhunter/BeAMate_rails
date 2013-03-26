class PasswordResetsMailer < ActionMailer::Base
  default :from => "firstmate@beamate.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_resets_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Reset your BeAMate password")
  end
end
