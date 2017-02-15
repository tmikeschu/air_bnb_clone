class AddLatitudeAndLongitudeToCouches < ActiveRecord::Migration[5.0]
  def change
    add_column :couches, :latitude, :float
    add_column :couches, :longitude, :float
  end
end
