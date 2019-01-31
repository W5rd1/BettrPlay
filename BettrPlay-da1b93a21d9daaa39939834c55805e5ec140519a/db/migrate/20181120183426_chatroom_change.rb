class ChatroomChange < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :chat_rooms_id
    add_reference :messages, :chatroom, index: true
  end
end
