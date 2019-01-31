class AddGuestresponseAndHostresponseToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :Guestresponse, :string
    add_column :challenges, :Hostresponse, :string
  end
end
