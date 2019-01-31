class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.integer :chat_room_id
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
