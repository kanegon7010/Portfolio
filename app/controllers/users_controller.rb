class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  
  def index
    @users = User.all
  end
 
  def show
    @user = User.find(params[:id])
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
