class MatepostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  respond_to :html, :js

  def create
    @matepost = current_user.mateposts.build(params[:matepost])

    respond_to do |format|
      if @matepost.save
        flash[:success] = "Mate post successfully created!"
        format.html { redirect_to root_path, :layout => !request.xhr? }
        format.js { render :js => @matepost, :status => :created, :location => @comment, :layout => !request.xhr? }
      else
        format.html { render 'static_pages/matepost_item', :layout => !request.xhr? }
        format.js { render :js => @matepost.errors, :status => :unprocessable_entity }
      #else
        #@feed_items = []
        #render 'static_pages/matepost_item'
      end
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