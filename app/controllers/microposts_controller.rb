class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def show
    @main_micropost = Micropost.find(params[:id])
    @micropost = current_user.microposts.build
    @reply_microposts = @main_micropost.replied.preload(:user,:replying_relationships, :replying, :replied_relationships, :replied)
    
    @before_main_micropost_list =[]
    if @main_micropost.replying.nil?
      present_flag = nil
    else
      present_flag = @main_micropost.replying.id 
    end
    before_main_micropost = @main_micropost.replying

    while present_flag != nil
      @before_main_micropost_list.push(before_main_micropost)
      if before_main_micropost.replying.nil?
        present_flag = nil
      else
        before_main_micropost = before_main_micropost.replying
        present_flag = before_main_micropost.id
      end
    end
    @before_main_micropost_list = @before_main_micropost_list.reverse    
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      if reply_chk
        ReplyRelationship.create(main_micropost_id: @main_micropost_id, reply_micropost_id: @micropost.id)
      end
      flash[:success] = "Micropost created!"
      @feed_microposts = current_user.feed
      respond_to do |format|
        format.html {redirect_back(fallback_location: root_url)}
        format.js
      end
    else
      @feed_items = []
      render 'home/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    @feed_microposts = current_user.feed
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, reply_relationship: [:main_micropost_id])
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def reply_chk
      if params.dig(:reply_relationship,:main_micropost_id)
        @main_micropost_id = params[:reply_relationship][:main_micropost_id]
      else
        false
      end
    end
    
end
