class AddWinnerLoserToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_reference :challenges, :winner, index: true
    add_reference :challenges, :loser, index: true
  end
end
