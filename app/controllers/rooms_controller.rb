class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]

  def index
    rooms = Entry.select("room_id").where(user_id: current_user.id)
    if rooms.present?
      @rooms_present = true
      @others = Entry.eager_load(:user).where(room_id: rooms).where.not(user_id: current_user.id)
    else
      @rooms_present = false
    end
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = Message.eager_load(:room,:user).where(room_id: @room.id)
      @message = Message.new
      @entries = @room.entries.preload(:user)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @otheruser = User.find(params[:user_id])
    if follow_for_follow?(@otheruser.id)
      room_make_check(@otheruser)
      if @isRoom
        redirect_to room_path(@roomId)
      else
        room = Room.create
        entry1 = Entry.create(room_id: room.id, user_id: current_user.id)
        entry2 = Entry.create(params.permit(:user_id).merge(room_id: room.id))
        redirect_to room_path(room.id)
      end
    else
      redirect_to root_path 
    end
  end
end
