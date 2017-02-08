class CreateNight < ActiveRecord::Migration[5.0]
  def change
    create_table :nights do |t|
      t.date :date
      t.references :couch, foreign_key: true
      t.references :reservation, foreign_key: true

      t.timestamps null: false
    end
  end
end
