class InvitationsMailer < ActionMailer::Base
  default :from => "firstmate@beamate.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitations_mailer.invitation.subject
  #
  def new_invitation(invitation)
    @invitation = invitation
    mail(:to => invitation.recipient_email, :subject => "You're invited to BeAMate beta!")
    invitation.update_attribute(:sent_at, Time.now)
  end
end
