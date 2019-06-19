class DirectMessagesController < ApplicationController
  def create
    @direct_message = DirectMessage.new(direct_message_params)
    @conversation = Conversation.find(params[:conversation_id])
    @direct_message.conversation = @conversation
    @direct_message.user = current_user
    if @direct_message.save!
      respond_to do |format|
        format.html { redirect_to conversation_path(@conversation) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "conversations/show" }
        format.js
      end
    end
  end

  def update
    # <ActionController::Parameters {, "controller"=>"direct_messages", "action"=>"update", "conversation_id"=>"20", "id"=>"82", "direct_message"=>{}} permitted: false>
    p 'toto'
    direct_message = DirectMessage.find(params['id'])
    unless direct_message.user == current_user
      direct_message.direct_message_read
    end
    p direct_message
    p 'otot'
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:body)
  end
end
