class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :reference
      t.float :amount
      t.integer :status
      t.references :user

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
