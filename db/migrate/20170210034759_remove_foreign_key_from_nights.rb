class RemoveForeignKeyFromNights < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :nights, :reservations
  end
end
