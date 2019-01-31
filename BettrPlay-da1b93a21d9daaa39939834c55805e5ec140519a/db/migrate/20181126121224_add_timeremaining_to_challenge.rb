class AddTimeremainingToChallenge < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :time_remaining, :integer
  end
end
