class CreateReservation < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
