class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  respond_to :html, :js

  def show
    @user = User.find(params[:id])
    render "show.html.erb", :layout => false
  end

  def new
    if signed_in?
      redirect_to root_path
    end
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.add_mate_points(BeAMateRails::Application::SIGNUP_MATE_POINTS)
      @my_invitation = Invitation.find_by_recipient_email(@user.email)
      if (@my_invitation.sender_id != nil)
        @my_referer = User.find_by_id(@my_invitation.sender_id)
        @my_referer.add_mate_points(BeAMateRails::Application::INVITE_MATE_POINTS)
      end
      sign_in @user
      flash[:user_signup] = "Welcome to BeAMate! We're giving you #{BeAMateRails::Application::SIGNUP_MATE_POINTS} just for signing up!"
      respond_with(@user, :location => root_path)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfully deleted."
    redirect_to users_url
  end

  def edit
    render "edit.html.erb", :layout => false
  end

  def update
    if @user.update_attributes( params[:user])
      flash[:update_user_details] = "Your profile was successfully updated!"
      sign_in @user
      respond_with(@user, :location => root_path)
    end
  end

  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def empty_trash
    current_user.mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(:deleted => true)
    end
    redirect_to(conversations_path(:show => 'trash'))
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end


end
