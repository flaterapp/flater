class DirectMessage < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :body, presence: true, allow_blank: false
  after_create :broadcast_message

  def from?(some_user)
    user == some_user
  end

  def broadcast_message
    ActionCable.server.broadcast("conversation_#{conversation.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "direct_messages/direct_message",
        locals: { direct_message: self, user_is_messages_author: false }
      ),
      current_user_id: user.id
    })
  end
end
