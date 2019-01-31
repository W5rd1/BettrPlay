class AddForeignKeyToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :chat_rooms, index: true
  end
end
