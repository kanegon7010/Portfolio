class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]

  def index
    rooms = []
    entries = Entry.where(user_id: current_user.id)
    entries.each do |entry|
      rooms.push(entry.room_id)
    end
    @others = Entry.eager_load(:user).where(room_id: rooms).where.not(user_id: current_user.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    otheruser = params[:user_id]
    currentUserEntry = Entry.where(user_id: current_user.id)
    otherUserEntry = Entry.where(user_id: otheruser)
    unless otheruser == current_user.id
      currentUserEntry.each do |cu|
        otherUserEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
        redirect_to room_path(@roomId)
      else
        room = Room.create
        entry1 = Entry.create(room_id: room.id, user_id: current_user.id)
        entry2 = Entry.create(params.permit(:user_id).merge(room_id: room.id))
        redirect_to room_path(room.id)
      end
    else
      redirect_back(fallback_location: user_path(otheruser))
    end
  end
end
