class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  respond_to :html, :js

  def show
    @user = User.find(params[:id])
    @user_request_feed_items = @user.user_request_feed
    @user_mate_feed_items =@user.user_mate_feed
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
      sign_in @user
      flash[:success] = "Welcome to BeAMate!"
      respond_with(@user, :location => root_path)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfully deleted."
    redirect_to users_url
  end

  def edit
  end

  def update
       if @user.update_attributes( params[:user])
      flash[:success] = "Your profile successfully updated!"
      sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
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
