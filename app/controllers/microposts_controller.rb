class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

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
