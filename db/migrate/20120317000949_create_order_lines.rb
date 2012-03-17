class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.references :orders
      t.references :product
      t.integer :quantity
      t.float :amount

      t.timestamps
    end
    add_index :order_lines, :order_id
    add_index :order_lines, :product_id
  end
end
