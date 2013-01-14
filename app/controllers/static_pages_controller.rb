class StaticPagesController < ApplicationController

  before_filter :signed_in_user, only: [:request_item]
  
  def home
    if signed_in?
      @feed_items = current_user.general_feed
    end
  end

  def help
  end
  
  def contact
  end

  def about
  end

  def request_item
    if signed_in?
      @micropost = current_user.microposts.build
    end
  end

end
