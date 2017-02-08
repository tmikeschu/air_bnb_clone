class SetDefaultStatusForReservationsToPending < ActiveRecord::Migration[5.0]
  def change
    change_column :reservations, :status, :integer, default: 0
  end
end
