class AddRefsChatroom < ActiveRecord::Migration[5.2]
  def change
    remove_column :chatrooms, :sender_id
    remove_column :chatrooms, :receiver_id
    add_reference :chatrooms, :sender, index: true
    add_reference :chatrooms, :receiver, index: true
  end
end
