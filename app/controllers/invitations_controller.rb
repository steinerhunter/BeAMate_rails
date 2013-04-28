class InvitationsController < ApplicationController
  respond_to :html, :js

  def new
    @invitation = Invitation.new
    render "new.html.erb", :layout => false
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      if signed_in?
        InvitationsMailer.new_invitation(@invitation).deliver
        flash[:invite_signedin] = "Well, you're quite awesome! You'll get #{BeAMateRails::Application::INVITE_MATE_POINTS} Mate Points once your friend signs up."
        respond_with(@invitation, :location => root_path)
      else
        flash[:invite_not_signedin] = "Thanks! We promise to let you know as soon as we're ready."
        respond_with(@invitation, :location => root_path)
      end
    end
  end

  def index
    if current_user.admin?
      @invitations = Invitation.all
    else
      redirect_to root_path
    end
  end

end
