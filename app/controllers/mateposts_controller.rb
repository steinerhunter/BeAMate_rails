class MatepostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy
  respond_to :html, :js

  def create
    @matepost = current_user.mateposts.build(params[:matepost])
    if @matepost.save
      respond_with(@matepost, :location => root_path)
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
      if current_user.admin?
        @matepost = Matepost.find_by_id(params[:id])
      else
        @matepost = current_user.mateposts.find_by_id(params[:id])
      end
      redirect_to root_url if @matepost.nil?
    end

end