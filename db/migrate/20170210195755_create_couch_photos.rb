class CreateCouchPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :couch_photos do |t|
      t.string :title
      t.string :caption
      t.string :image
      t.references :couch, foreign_key: true

      t.timestamps
    end
  end
end
