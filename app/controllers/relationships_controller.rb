class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user =User.find(params[:relationship][:following_id])
    current_user.follow(@user)
    room_make_check(@user)
    if @isRoom
    else
      @room = Room.new
      @entry = Entry.new
    end
    respond_to do |format|
        format.html {redirect_back(fallback_location: root_url)}
        format.js
    end
  end

  def destroy
    @user = User.find(params[:relationship][:following_id])
    current_user.unfollow(@user)
    room_make_check(@user)
    respond_to do |format|
        format.html {redirect_back(fallback_location: root_url)}
        format.js
    end
  end
end
