class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :reservation, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
