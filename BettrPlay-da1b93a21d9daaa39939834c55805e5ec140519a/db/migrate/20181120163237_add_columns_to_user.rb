class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :fullname, :string
    add_column :users, :dob, :date
    add_column :users, :region, :string
    add_column :users, :rank, :string
    add_column :users, :bio, :text
  end
end
