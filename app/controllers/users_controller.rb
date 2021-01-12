class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :followings, :followers]
  
  def index
    @users = User.all
  end
 
  def show
    @user = User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end  

  def followings
    @user =User.find(params[:id])
    @users =@user.followings
    render 'show_followings'
  end

  def followers
    @user =User.find(params[:id])
    @users =@user.followers
    render 'show_followers'
  end
  
end
