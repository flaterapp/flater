class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations
  end

  def show
    @conversations = current_user.conversations
    @conversation = Conversation.includes(direct_messages: :user).find(params[:id])
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
