class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_room, only: [:create, :destroy]
  before_action :to_dm_user, only: [:create, :destroy]

  def create
    if follow_for_follow?(@otheruser.id)
      if Entry.where(user_id: current_user.id, room_id: @room.id).present?
        @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
        gets_entries_all_messages
        respond_to do |format|
          format.html {redirect_back(fallback_location: root_url)}
          format.js
        end
      else
        flash[:alert] = "メッセージ送信に失敗しました。"
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if follow_for_follow?(@otheruser.id)
      message = Message.find(params[:id])
      message.destroy
      gets_entries_all_messages
      respond_to do |format|
        format.html {redirect_back(fallback_location: root_url)}
        format.js
      end
    else
      redirect_to root_path, flash: {
        alert: @otheruser
      }
    end
  end

  private

  def set_room
    @room = Room.find(params[:message][:room_id])
  end

  def gets_entries_all_messages
    @messages = @room.messages.includes(:user).order("created_at asc")
  end

  def to_dm_user
    @entries = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
    @entries.each do |entry|
      @otheruser = entry.user
    end
  end

end
