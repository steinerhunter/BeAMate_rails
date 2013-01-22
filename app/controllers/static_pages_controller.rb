class StaticPagesController < ApplicationController

  before_filter :signed_in_user, only: [:request_item, :matepost_item]
  
  def home
    if signed_in?
      @request_feed_items = current_user.request_feed
      @mate_feed_items = current_user.mate_feed
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
      @requestpost = current_user.requestposts.build
    end
  end

  def matepost_item
    if signed_in?
      @matepost = current_user.mateposts.build
    end
  end

end
