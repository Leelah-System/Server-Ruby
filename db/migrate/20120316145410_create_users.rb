class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :token
      t.string :salt
      t.integer :status

      t.timestamps
    end
  end
end
