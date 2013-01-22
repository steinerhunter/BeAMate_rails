class RequestpostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def create
    @requestpost = current_user.requestposts.build(params[:requestpost])
    if @requestpost.save
      flash[:success] = "Request successfully created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/request_item'
    end
  end

  def destroy
    @requestpost.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @requestpost = current_user.requestposts.find_by_id(params[:id])
      redirect_to root_url if @requestpost.nil?
    end

end