class RemoveColMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :chat_room_id
  end
end
