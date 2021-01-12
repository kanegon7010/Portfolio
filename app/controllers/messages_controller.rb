class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_room, only: [:create, :destroy]

  def create
    if Entry.where(user_id: current_user.id, room_id: set_room).present?
      @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
      gets_entries_all_messages
      respond_to do |format|
        format.html {redirect_back(fallback_location: root_url)}
        format.js
      end
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    gets_entries_all_messages
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    end
  end

  private

  def set_room
      @room = Room.find(params[:message][:room_id])
  end

  def gets_entries_all_messages
    @messages = @room.messages.includes(:user).order("created_at asc")
  end
  

end
