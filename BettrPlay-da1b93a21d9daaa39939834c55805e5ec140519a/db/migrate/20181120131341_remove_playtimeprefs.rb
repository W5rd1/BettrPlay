class RemovePlaytimeprefs < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :playtime_preferences
  end
end
