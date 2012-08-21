class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :cellphone
      t.string :fax
      t.references :contactable, :polymorphic => true

      t.timestamps
    end
    add_index :contacts, :contactable_id
  end
end
