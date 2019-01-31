class CreateDisputes < ActiveRecord::Migration[5.2]
  def change
    create_table :disputes do |t|
      t.date :date
      t.text :description
      t.boolean :solved

      t.timestamps
    end
  end
end
