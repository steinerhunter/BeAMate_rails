class SessionsController < ApplicationController
  respond_to :html, :js

  def new
    render "new.html.erb", :layout => false
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    @session = user && user.authenticate(params[:session][:password])
    if @session
      sign_in user
      respond_with(user, :location => root_path)
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
