class AddChallengesToDisputes < ActiveRecord::Migration[5.2]
  def change
    add_reference :disputes, :challenge, foreign_key: true
  end
end
