class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    @chat_rooms = ChatRoom.all
    @chat_room = ChatRoom.includes(messages: :user).find(params[:id])
  end

  def create
    chat_room = ChatRoom.create!(chat_room_params)
    redirect_to chat_room_path(chat_room)
  end

  def destroy
    @chat_room = ChatRoom.find(params[:id])
    @chat_room.destroy
    respond_to do |format|
      format.html { redirect_to chat_rooms_path, notice: 'Chat-room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
