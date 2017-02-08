class CreateCouches < ActiveRecord::Migration[5.0]
  def change
    create_table :couches do |t|
      t.text :name
      t.text :description
      t.text :street_address
      t.text :city
      t.text :state
      t.text :zipcode

      t.timestamps
    end
  end
end
