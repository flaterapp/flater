class DirectMessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.direct_messages.create(message_params)
  end

  private

  def message_params
    params.require(:direct_message).permit(:user_id, :body)
  end
end
