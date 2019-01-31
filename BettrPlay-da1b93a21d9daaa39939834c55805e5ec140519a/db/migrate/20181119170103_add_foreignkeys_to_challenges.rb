class AddForeignkeysToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_reference :challenges, :host, index: true
    add_reference :challenges, :guest, index: true
  end
end
