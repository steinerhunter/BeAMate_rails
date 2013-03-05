class ContactController < ApplicationController
  respond_to :html, :js

  def new
    @feedback = Feedback.new
    render "new.html.erb", :layout => false
  end

  def create
    @feedback = Feedback.new(params[:feedback])

    if @feedback.valid?
      flash[:success] = "Thank you so much for your feedback!!"
      respond_with(@feedback, :location => root_path)
      NotificationsMailer.new_feedback(@feedback).deliver
    end
  end

end