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
      flash[:pass_reset_email] = "An email with password reset instructions is headed your way!"
      respond_with(@user, :location => root_path)
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :notice => "Your password reset windows has expired..."
    elsif @user.update_attributes(params[:user])
      flash[:pass_reset_success] = "You've successfully updated your password!!"
      respond_with(@user, :location => root_path)
    end
  end
end
