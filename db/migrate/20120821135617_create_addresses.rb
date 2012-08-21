class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :street_number
      t.string :street
      t.string :additional_address
      t.string :zip_code
      t.string :city
      t.string :country
      t.references :addressable, :polymorphic => true

      t.timestamps
    end
    add_index :addresses, :addressable_id
  end
end
