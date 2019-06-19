class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.where("recipient_id = ? OR sender_id = ?", current_user.id, current_user.id)
  end

  def show
    @conversations = Conversation.where("recipient_id = ? OR sender_id = ?", current_user.id, current_user.id)
    @conversation = Conversation.includes(direct_messages: :user).find(params[:id])
    @conversation.direct_messages.each { |direct_message|
      unless direct_message.user == current_user
        direct_message.direct_message_read
      end
    }
  end

  def create
    conversation = Conversation.get(current_user.id, params[:user_id])
    if !conversation.nil?
      respond_to do |format|
        format.html { redirect_to conversation_path(conversation) }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_path, notice: 'Chat-room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
