class MatepostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  respond_to :html, :js

  def create
    @matepost = current_user.mateposts.build(params[:matepost])
    if @matepost.save
      flash[:success] = "Request successfully created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/request_item'
    end
  end

  def destroy
    @matepost.destroy
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.json { head :no_content }
      format.js   { render :nothing => true }
    end
  end

  private

    def correct_user
      @matepost = current_user.mateposts.find_by_id(params[:id])
      redirect_to root_url if @matepost.nil?
    end

end