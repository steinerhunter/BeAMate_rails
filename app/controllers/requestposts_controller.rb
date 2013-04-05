class RequestpostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  respond_to :html, :js

  def create
    @requestpost = current_user.requestposts.build(params[:requestpost])
    if @requestpost.save
      respond_with(@requestpost, :location => root_path)
    end
  end

  def destroy
    @requestpost.destroy
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.json { head :no_content }
      format.js   { render :nothing => true }
      end
  end

  private

    def correct_user
      @requestpost = current_user.requestposts.find_by_id(params[:id])
      redirect_to root_url if @requestpost.nil?
    end

end