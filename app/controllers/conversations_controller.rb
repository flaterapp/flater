class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.includes(direct_messages: :user)
  end

  def show
    @conversations = Conversation.includes(direct_messages: :user)
    @conversation = Conversation.includes(direct_messages: :user).find(params[:id])
  end

  def create
    conversation = Conversation.find_by(recipient_id: params['user_id'])
    if conversation == nil
      conversation = Conversation.new
      conversation.recipient_id = params['user_id']
      conversation.sender_id = current_user.id
      conversation.save!
      respond_to do |format|
        format.html { redirect_to conversation_path(conversation) }
        format.json { head :no_content }
      end
    else
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
