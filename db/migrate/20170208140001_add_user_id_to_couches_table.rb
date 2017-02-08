class AddUserIdToCouchesTable < ActiveRecord::Migration[5.0]
  def change
    add_reference :couches, :user, foreign_key: true
  end
end
