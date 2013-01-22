class MatepostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def create
    @matepost = current_user.mateposts.build(params[:matepost])
    if @matepost.save
      flash[:success] = "Mate post successfully created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/matepost_item'
    end
  end

  def destroy
    @matepost.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @matepost = current_user.mateposts.find_by_id(params[:id])
      redirect_to root_url if @matepost.nil?
    end

end