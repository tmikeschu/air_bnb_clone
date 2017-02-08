class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.email, :email
      t.text, :first_name
      t.text, :last_name
      t.password_digest :password

      t.timestamps
    end
  end
end
