class AddDefaultValueToStatus < ActiveRecord::Migration[5.2]
  def change
      change_column :challenges, :status, :string, default: "open"
  end
end
