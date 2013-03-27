class PasswordResetsController < ApplicationController
  respond_to :html, :js

  def new
    render "new.html.erb", :layout => false
  end

  def create
    user = User.find_by_email(params[:email])
    @user = user
    if @user
      user.send_password_reset
      flash[:success] = "Thanks! We've sent an email with password reset instructions."
      respond_with(@user, :location => root_path)
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      flash[:success] = "Password has been reset!"
      respond_with(@user, :location => root_path)
    end
  end
end
