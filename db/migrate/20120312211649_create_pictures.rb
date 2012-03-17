class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :path
      t.string :label
      t.string :name
      t.text :description
      t.references :imageable, :polymorphic => true

      t.timestamps
    end
  end
end
