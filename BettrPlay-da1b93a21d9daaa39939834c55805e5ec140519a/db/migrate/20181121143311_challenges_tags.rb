class ChallengesTags < ActiveRecord::Migration[5.2]
  def change
    rename_column :challenges, :guest_gamerTag, :guest_gamertag
  end
end
