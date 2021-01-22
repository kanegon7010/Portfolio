class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :followings, :followers]
  
  def index
    @users = User.preload(:following_relationships,:followings,:follower_relationships,:followers)
  end
 
  def show
    @user = User.find(params[:id])
    @micropost = @user.microposts.build
    @microposts = Micropost.eager_load(:user).where(user_id: @user.id)
    room_make_check(@user)
    if @isRoom
    else
      @room = Room.new
      @entry = Entry.new
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
