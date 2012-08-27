class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :reference,  :null => false
      t.string :label
      t.string :name
      t.text :description
      t.float :price
      t.float :stock
      t.references :logo
      t.references :category

      t.timestamps
    end
  end
end
