class ContactController < ApplicationController

  def new
    @feedback = Feedback.new
    render "new.html.erb", :layout => false
  end

  def create
    @feedback = Feedback.new(params[:feedback])

    if @feedback.valid?
      NotificationsMailer.new_feedback(@feedback).deliver
      redirect_to(root_path, :success => "Feedback  successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end

end