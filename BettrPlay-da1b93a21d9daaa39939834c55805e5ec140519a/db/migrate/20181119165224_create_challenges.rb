class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :host_gamertag
      t.string :guest_gamerTag
      t.string :game
      t.string :playtime_preferences
      t.string :status
      t.integer :stake
      t.string :platform

      t.timestamps
    end
  end
end
