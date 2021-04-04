class ChatMessage < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  after_create_commit { ChatMessageBroadcastJob.perform_later self }
end
