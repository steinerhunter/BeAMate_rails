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
        flash[:success] = "Thanks! We've sent an invitation to the address you specified."
        respond_with(@invitation, :location => root_path)
      else
        flash[:success] = "Thanks! We promise to let you know as soon as we're ready."
        respond_with(@invitation, :location => root_path)
      end
    end
  end

end
