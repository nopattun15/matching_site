class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def create 
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room_id)
    chat_room = ChatRoomUser.where(chat_room_id: current_user_chat_rooms, user_id: params[:user_id]).map(&:chat_room_id).first
    if chat_room.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room_id: chat_room.id, user_id: current_user.id)
      ChatRoomUser.create(chat_room_id: chat_room.id, user_id: params[:user_id])
    end
    redirect_to action: :show, id: chat_room

  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user_id
    @user = User.find(@chat_room_user)
    @chat_messages = ChatMessage.where(chat_room_id: @chat_room)

  end

end
