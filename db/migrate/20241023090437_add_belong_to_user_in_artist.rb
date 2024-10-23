class AddBelongToUserInArtist < ActiveRecord::Migration[7.2]
  def change
    add_reference :singers, :user, null: true,  foreign_key: true
  end
end
