class HomesController < ApplicationController
  def index
    if user_signed_in?
      @micropost = current_user.microposts.build
      @feed_microposts = current_user.feed
    end
  end

  def show
  end
end
