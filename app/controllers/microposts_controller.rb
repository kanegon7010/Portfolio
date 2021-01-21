class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def show
    @main_micropost = Micropost.find(params[:id])
    @micropost = current_user.microposts.build
    @reply_microposts = Micropost.eager_load(:user,:replying, :replied).
          where("reply_relationships.main_micropost_id = :id", id: @main_micropost.id).reorder(nil).order(id: :asc)  
    
    @before_main_micropost_list =[]
    if @main_micropost.replying.nil?
      before_main_micropost_id = nil
    else
      before_main_micropost_id = @main_micropost.replying.id 
    end
    before_main_micropost = @main_micropost.replying

    while before_main_micropost_id != nil
      @before_main_micropost_list.push(before_main_micropost_id)
      if before_main_micropost.replying.nil?
        before_main_micropost_id = nil
      else
        before_main_micropost = before_main_micropost.replying
        before_main_micropost_id = before_main_micropost.id
      end
    end
    @before_main_micropost_list = Micropost.eager_load(:user, :replied).where(id: @before_main_micropost_list).reorder(nil).order(id: :asc)   
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      if reply_chk
        ReplyRelationship.create(main_micropost_id: @main_micropost_id, reply_micropost_id: @micropost.id)
      end
      unless request.referer&.include?("/microposts/")
        flash[:notice] = "Micropost created!"
        @feed_microposts = current_user.feed
        respond_to do |format|
          format.html {redirect_back(fallback_location: root_url)}
          format.js
        end
      else
        flash[:notice] = "Micropost created!"
        redirect_to micropost_path(@main_micropost_id)
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
      if request.referer&.include?("/microposts/")
        format.js {redirect_to root_path}
      else
        format.js
      end
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :main_micropost_id, :default_main_micropost_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def reply_chk
      if params.dig(:main_micropost_id)
        @main_micropost_id = params[:main_micropost_id]
      else
        if params.dig(:default_main_micropost_id)
          @main_micropost_id = params[:default_main_micropost_id]
        else
          false
        end
      end
    end
    
end
